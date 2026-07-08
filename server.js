import "dotenv/config";
import express from "express";
import cors from "cors";
import pg from "pg";

const { Pool } = pg;
const app = express();
const port = process.env.PORT || 3000;
const allowedOrigins = (process.env.CORS_ORIGIN || "")
  .split(",")
  .map((origin) => origin.trim())
  .filter(Boolean);

app.use(cors({
  origin(origin, callback) {
    if (!origin || allowedOrigins.length === 0 || allowedOrigins.includes(origin)) {
      callback(null, true);
      return;
    }

    callback(new Error("Not allowed by CORS"));
  }
}));
app.use(express.json());

const pool = new Pool({
  host: process.env.PGHOST || "localhost",
  port: Number(process.env.PGPORT || 5432),
  user: process.env.PGUSER || "postgres",
  password: process.env.PGPASSWORD,
  database: process.env.PGDATABASE || "Asian_elephant"
});

function emptyToNull(value) {
  return value === "" || value === undefined ? null : value;
}

function toNumberOrNull(value) {
  if (value === "" || value === undefined || value === null) {
    return null;
  }

  const number = Number(value);
  return Number.isFinite(number) ? number : null;
}

function toIntegerOrNull(value) {
  const number = toNumberOrNull(value);
  return number === null ? null : Math.trunc(number);
}

app.get("/", (req, res) => {
  res.send("Survey-ae is running");
});

app.get("/api/health", async (req, res) => {
  try {
    await pool.query("SELECT 1");
    res.json({
      success: true,
      service: "survey-api",
      database: "connected"
    });
  } catch (err) {
    res.status(503).json({
      success: false,
      service: "survey-api",
      database: "unavailable",
      error: err.message,
      code: err.code,
      detail: err.detail
    });
  }
});

app.post("/api/surveys", async (req, res) => {
  let client;

  try {
    client = await pool.connect();

    const {
      basic = {},
      section_a = {},
      section_b = {},
      section_c = {},
      section_d = {},
      section_e = {},
      section_f = {},
      section_g = {},
      section_h = {},
      section_j = {}
    } = req.body;
    const surveyId = emptyToNull(basic.survey_id);

    if (!surveyId || !basic.survey_date || !basic.enumerator_name || !basic.village_name || !basic.district) {
      return res.status(400).json({
        success: false,
        message: "Missing required survey information"
      });
    }

    const longitude = toNumberOrNull(basic.longitude);
    const latitude = toNumberOrNull(basic.latitude);

    if (longitude === null || latitude === null) {
      return res.status(400).json({
        success: false,
        message: "Longitude and latitude are required"
      });
    }

    const existingSurvey = await client.query(
      "SELECT 1 FROM information WHERE survey_id = $1 LIMIT 1",
      [surveyId]
    );

    if (existingSurvey.rowCount > 0) {
      return res.status(409).json({
        success: false,
        message: "Survey ID already exists",
        survey_id: surveyId
      });
    }

    await client.query("BEGIN");

    await client.query(
      `
      INSERT INTO information (
        survey_id,
        survey_date,
        enumerator_name,
        village_name,
        district,
        gps_coordinates,
        respondent_code
      )
      VALUES (
        $1, $2, $3, $4, $5,
        ST_SetSRID(ST_MakePoint($6, $7), 4326),
        $8
      )
      `,
      [
        surveyId,
        emptyToNull(basic.survey_date),
        emptyToNull(basic.enumerator_name),
        emptyToNull(basic.village_name),
        emptyToNull(basic.district),
        longitude,
        latitude,
        emptyToNull(basic.respondent_code)
      ]
    );

    await client.query(
      `
      INSERT INTO respondent_profile (
        survey_id,
        gender,
        age,
        marital_status,
        education_level,
        occupation,
        occupation_other,
        household_size,
        number_of_income_earners
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      `,
      [
        surveyId,
        emptyToNull(section_a.gender),
        toIntegerOrNull(section_a.age),
        emptyToNull(section_a.marital_status),
        emptyToNull(section_a.education_level),
        emptyToNull(section_a.occupation_main),
        emptyToNull(section_a.occupation_other),
        toIntegerOrNull(section_a.household_size),
        toIntegerOrNull(section_a.income_earners)
      ]
    );

    await client.query(
      `
      INSERT INTO socioeconomic_characteristic (
        survey_id,
        average_monthly_household_group,
        main_income_source,
        main_income_source_other,
        own_agriculture_land,
        area_owned
      )
      VALUES ($1, $2, $3, $4, $5, $6)
      `,
      [
        surveyId,
        emptyToNull(section_b.monthly_income_group),
        emptyToNull(section_b.main_income_source),
        emptyToNull(section_b.main_income_source_other),
        emptyToNull(section_b.owns_agricultural_land),
        toNumberOrNull(section_b.land_area_ha)
      ]
    );

    for (const landUseType of section_b.land_use_types || []) {
      await client.query(
        `
        INSERT INTO section_b_landuse_types (
          survey_id,
          land_use_type,
          land_use_type_other
        )
        VALUES ($1, $2, $3)
        `,
        [
          surveyId,
          landUseType,
          landUseType === "Other" ? section_b.land_use_type_other : null
        ]
      );
    }

    const livestock = section_b.livestock || {};
    const livestockMap = [
      ["Cattle", livestock.cattle],
      ["Buffalo", livestock.buffalo],
      ["Goat", livestock.goat],
      ["Sheep", livestock.sheep],
      ["Others", livestock.others]
    ];

    for (const [livestockType, livestockNumber] of livestockMap) {
      if (livestockNumber !== null && livestockNumber !== undefined && livestockNumber !== "") {
        await client.query(
          `
          INSERT INTO section_b_livestock_ownership (
            survey_id,
            livestock_type,
            livestock_number
          )
          VALUES ($1, $2, $3)
          `,
          [surveyId, livestockType, toIntegerOrNull(livestockNumber)]
        );
      }
    }

    await client.query(
      `
      INSERT INTO landuse_and_environmental_change (
        survey_id,
        change_degree,
        distance_from_home_to_forest,
        distance_from_farmland_to_forest
      )
      VALUES ($1, $2, $3, $4)
      `,
      [
        surveyId,
        emptyToNull(section_c.land_use_change_level),
        emptyToNull(section_c.distance_home_forest_group),
        toNumberOrNull(section_c.distance_farmland_forest_km)
      ]
    );

    for (const changeType of section_c.change_types || []) {
      await client.query(
        `
        INSERT INTO section_c_main_observed_changes (
          survey_id,
          main_observed_changes,
          main_observed_changes_other
        )
        VALUES ($1, $2, $3)
        `,
        [
          surveyId,
          changeType,
          changeType === "Other" ? section_c.change_type_other : null
        ]
      );
    }

    for (const waterSource of section_c.water_sources || []) {
      await client.query(
        `
        INSERT INTO section_c_precense_of_watersources (
          survey_id,
          water_source_type
        )
        VALUES ($1, $2)
        `,
        [surveyId, waterSource]
      );
    }

    await client.query(
      `
      INSERT INTO elephant_precense_and_distribution (
        survey_id,
        ever_seen_elephant,
        elephant_appear_frequency,
        elephant_common_distance_km,
        elephant_season,
        herd_size_group,
        elephant_number_change,
        elephant_route_change,
        elephant_route_change_explanation
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      `,
      [
        surveyId,
        emptyToNull(section_d.seen_elephants),
        emptyToNull(section_d.elephant_frequency),
        toNumberOrNull(section_d.elephant_common_distance_km),
        emptyToNull(section_d.elephant_season),
        emptyToNull(section_d.herd_size_group),
        emptyToNull(section_d.elephant_number_change),
        emptyToNull(section_d.elephant_route_change),
        emptyToNull(section_d.elephant_route_change_explanation)
      ]
    );

    for (const location of section_d.elephant_common_locations || []) {
      await client.query(
        `
        INSERT INTO section_d_elephant_common_locations (
          survey_id,
          location_type,
          location_other
        )
        VALUES ($1, $2, $3)
        `,
        [
          surveyId,
          location,
          location === "Other" ? section_d.elephant_common_location_other : null
        ]
      );
    }

    await client.query(
      `
      INSERT INTO section_e_human_elephant_conflict (
        survey_id,
        crop_damage,
        crop_damage_frequency,
        economic_loss_group,
        property_damage,
        human_injury,
        human_death
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7)
      `,
      [
        surveyId,
        emptyToNull(section_e.crop_damage),
        emptyToNull(section_e.crop_damage_frequency),
        emptyToNull(section_e.economic_loss_group),
        emptyToNull(section_e.property_damage),
        emptyToNull(section_e.human_injury),
        emptyToNull(section_e.human_death)
      ]
    );

    for (const cropType of section_e.crop_types || []) {
      await client.query(
        `
        INSERT INTO section_e_crop_types (
          survey_id,
          crop_type,
          crop_type_other
        )
        VALUES ($1, $2, $3)
        `,
        [
          surveyId,
          cropType,
          cropType === "Other" ? section_e.crop_type_other : null
        ]
      );
    }

    for (const method of section_e.deterrence_methods || []) {
      await client.query(
        `
        INSERT INTO section_e_deterrence_methods (
          survey_id,
          method,
          method_other
        )
        VALUES ($1, $2, $3)
        `,
        [
          surveyId,
          method,
          method === "Other" ? section_e.deterrence_method_other : null
        ]
      );
    }

    await client.query(
      `
      INSERT INTO section_f_perceptions (
        survey_id,
        elephants_important_ecosystem,
        elephant_population_protected,
        government_programs_effective,
        conflict_increasing,
        communities_benefit_conservation,
        habitats_preserved,
        development_affects_distribution,
        agricultural_expansion_reduces_habitat
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      `,
      [
        surveyId,
        emptyToNull(section_f.elephants_important_ecosystem),
        emptyToNull(section_f.elephant_population_protected),
        emptyToNull(section_f.government_programs_effective),
        emptyToNull(section_f.conflict_increasing),
        emptyToNull(section_f.communities_benefit_conservation),
        emptyToNull(section_f.habitats_preserved),
        emptyToNull(section_f.development_affects_distribution),
        emptyToNull(section_f.agricultural_expansion_reduces_habitat)
      ]
    );

    await client.query(
      `
      INSERT INTO section_g_development_indicators (
        survey_id,
        road_infrastructure_change,
        agricultural_expansion_change,
        population_density_change,
        new_business_nearby,
        household_income_change
      )
      VALUES ($1, $2, $3, $4, $5, $6)
      `,
      [
        surveyId,
        emptyToNull(section_g.road_infrastructure_change),
        emptyToNull(section_g.agricultural_expansion_change),
        emptyToNull(section_g.population_density_change),
        emptyToNull(section_g.new_business_nearby),
        emptyToNull(section_g.household_income_change)
      ]
    );

    await client.query(
      `
      INSERT INTO section_h_community_knowledge (
        survey_id,
        knows_traditional_routes,
        traditional_route_description,
        elders_know_routes,
        community_conservation,
        community_conservation_description
      )
      VALUES ($1, $2, $3, $4, $5, $6)
      `,
      [
        surveyId,
        emptyToNull(section_h.knows_traditional_routes),
        emptyToNull(section_h.traditional_route_description),
        emptyToNull(section_h.elders_know_routes),
        emptyToNull(section_h.community_conservation),
        emptyToNull(section_h.community_conservation_description)
      ]
    );

    await client.query(
      `
      INSERT INTO section_j_open_ended_questions (
        survey_id,
        reason_elephants_occur,
        development_effect_on_movements,
        conflict_reduction_measures,
        additional_comments
      )
      VALUES ($1, $2, $3, $4, $5)
      `,
      [
        surveyId,
        emptyToNull(section_j.reason_elephants_occur),
        emptyToNull(section_j.development_effect_on_movements),
        emptyToNull(section_j.conflict_reduction_measures),
        emptyToNull(section_j.additional_comments)
      ]
    );

    await client.query("COMMIT");

    res.json({
      success: true,
      message: "Survey saved successfully",
      survey_id: surveyId
    });
  } catch (err) {
    if (client) {
      await client.query("ROLLBACK");
    }
    console.error("Failed to save survey:", err);
    res.status(500).json({
      success: false,
      message: "Failed to save survey",
      error: err.message
    });
  } finally {
    client?.release();
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
