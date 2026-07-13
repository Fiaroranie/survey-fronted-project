-- Align the PostgreSQL schema with the current server.js insert statements.
-- Run once on the production database:
-- psql -d "Asian Elephant" -f migrations/2026-07-13-align-survey-schema.sql

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'respondent_profile' AND column_name = 'occupation_other'
  ) THEN
    ALTER TABLE public.respondent_profile ADD COLUMN occupation_other text;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'socioeconomic_characteristic' AND column_name = 'average_monthly_household_income'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'socioeconomic_characteristic' AND column_name = 'average_monthly_household_group'
  ) THEN
    ALTER TABLE public.socioeconomic_characteristic
      RENAME COLUMN average_monthly_household_income TO average_monthly_household_group;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'socioeconomic_characteristic' AND column_name = 'main_income_source_other'
  ) THEN
    ALTER TABLE public.socioeconomic_characteristic ADD COLUMN main_income_source_other text;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'section_b_landuse_types' AND column_name = 'landuse_type'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'section_b_landuse_types' AND column_name = 'land_use_type'
  ) THEN
    ALTER TABLE public.section_b_landuse_types RENAME COLUMN landuse_type TO land_use_type;
  END IF;

  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'section_b_landuse_types' AND column_name = 'landuse_type_other'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'section_b_landuse_types' AND column_name = 'land_use_type_other'
  ) THEN
    ALTER TABLE public.section_b_landuse_types RENAME COLUMN landuse_type_other TO land_use_type_other;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'landuse_and_environmental_change' AND column_name = 'diatance_from_farmland_to_forest'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'landuse_and_environmental_change' AND column_name = 'distance_from_farmland_to_forest'
  ) THEN
    ALTER TABLE public.landuse_and_environmental_change
      RENAME COLUMN diatance_from_farmland_to_forest TO distance_from_farmland_to_forest;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'section_c_precense_of_watersources' AND column_name = 'precense_of_watersources'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'section_c_precense_of_watersources' AND column_name = 'water_source_type'
  ) THEN
    ALTER TABLE public.section_c_precense_of_watersources
      RENAME COLUMN precense_of_watersources TO water_source_type;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'elephant_precense_and_distribution' AND column_name = 'distance_from_center_to_where_observed')
    AND NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'elephant_precense_and_distribution' AND column_name = 'elephant_common_distance_km') THEN
    ALTER TABLE public.elephant_precense_and_distribution RENAME COLUMN distance_from_center_to_where_observed TO elephant_common_distance_km;
  END IF;

  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'elephant_precense_and_distribution' AND column_name = 'season_most_observed')
    AND NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'elephant_precense_and_distribution' AND column_name = 'elephant_season') THEN
    ALTER TABLE public.elephant_precense_and_distribution RENAME COLUMN season_most_observed TO elephant_season;
  END IF;

  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'elephant_precense_and_distribution' AND column_name = 'typical_herd_size')
    AND NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'elephant_precense_and_distribution' AND column_name = 'herd_size_group') THEN
    ALTER TABLE public.elephant_precense_and_distribution RENAME COLUMN typical_herd_size TO herd_size_group;
  END IF;

  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'elephant_precense_and_distribution' AND column_name = 'change_in_elephant_number')
    AND NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'elephant_precense_and_distribution' AND column_name = 'elephant_number_change') THEN
    ALTER TABLE public.elephant_precense_and_distribution RENAME COLUMN change_in_elephant_number TO elephant_number_change;
  END IF;

  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'elephant_precense_and_distribution' AND column_name = 'change_in_movement_routes')
    AND NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'elephant_precense_and_distribution' AND column_name = 'elephant_route_change') THEN
    ALTER TABLE public.elephant_precense_and_distribution RENAME COLUMN change_in_movement_routes TO elephant_route_change;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'human_elephant_conflict')
    AND NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'section_e_human_elephant_conflict') THEN
    ALTER TABLE public.human_elephant_conflict RENAME TO section_e_human_elephant_conflict;
  END IF;

  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_e_human_elephant_conflict' AND column_name = 'damage_crops') THEN
    ALTER TABLE public.section_e_human_elephant_conflict RENAME COLUMN damage_crops TO crop_damage;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_e_human_elephant_conflict' AND column_name = 'frequency_of_damage_crops') THEN
    ALTER TABLE public.section_e_human_elephant_conflict RENAME COLUMN frequency_of_damage_crops TO crop_damage_frequency;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_e_human_elephant_conflict' AND column_name = 'estimated_economic_loss_per_year') THEN
    ALTER TABLE public.section_e_human_elephant_conflict RENAME COLUMN estimated_economic_loss_per_year TO economic_loss_group;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_e_human_elephant_conflict' AND column_name = 'damage_property') THEN
    ALTER TABLE public.section_e_human_elephant_conflict RENAME COLUMN damage_property TO property_damage;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_e_human_elephant_conflict' AND column_name = 'injure_people') THEN
    ALTER TABLE public.section_e_human_elephant_conflict RENAME COLUMN injure_people TO human_injury;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_e_human_elephant_conflict' AND column_name = 'kill_people') THEN
    ALTER TABLE public.section_e_human_elephant_conflict RENAME COLUMN kill_people TO human_death;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'section_e_affected_crop_type')
    AND NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'section_e_crop_types') THEN
    ALTER TABLE public.section_e_affected_crop_type RENAME TO section_e_crop_types;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_e_crop_types' AND column_name = 'affected_crop_type') THEN
    ALTER TABLE public.section_e_crop_types RENAME COLUMN affected_crop_type TO crop_type;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_e_crop_types' AND column_name = 'affected_crop_type_other') THEN
    ALTER TABLE public.section_e_crop_types RENAME COLUMN affected_crop_type_other TO crop_type_other;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'methods_deter_elephants')
    AND NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'section_e_deterrence_methods') THEN
    ALTER TABLE public.methods_deter_elephants RENAME TO section_e_deterrence_methods;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_e_deterrence_methods' AND column_name = 'methods_deter_elephants') THEN
    ALTER TABLE public.section_e_deterrence_methods RENAME COLUMN methods_deter_elephants TO method;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_e_deterrence_methods' AND column_name = 'methods_deter_elephants_other') THEN
    ALTER TABLE public.section_e_deterrence_methods RENAME COLUMN methods_deter_elephants_other TO method_other;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'perceptions_elephant_conservation')
    AND NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'section_f_perceptions') THEN
    ALTER TABLE public.perceptions_elephant_conservation RENAME TO section_f_perceptions;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_f_perceptions' AND column_name = 'elephants_important_for_ecosystems') THEN
    ALTER TABLE public.section_f_perceptions RENAME COLUMN elephants_important_for_ecosystems TO elephants_important_ecosystem;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_f_perceptions' AND column_name = 'elephant_populations_should_be_protected') THEN
    ALTER TABLE public.section_f_perceptions RENAME COLUMN elephant_populations_should_be_protected TO elephant_population_protected;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_f_perceptions' AND column_name = 'government_conservation_programs_are_effective') THEN
    ALTER TABLE public.section_f_perceptions RENAME COLUMN government_conservation_programs_are_effective TO government_programs_effective;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_f_perceptions' AND column_name = 'human_elephant_conflict_is_increasing') THEN
    ALTER TABLE public.section_f_perceptions RENAME COLUMN human_elephant_conflict_is_increasing TO conflict_increasing;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_f_perceptions' AND column_name = 'local_communities_benefit_from_elephant_conservation') THEN
    ALTER TABLE public.section_f_perceptions RENAME COLUMN local_communities_benefit_from_elephant_conservation TO communities_benefit_conservation;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_f_perceptions' AND column_name = 'elephant_habitats_should_be_preserved') THEN
    ALTER TABLE public.section_f_perceptions RENAME COLUMN elephant_habitats_should_be_preserved TO habitats_preserved;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_f_perceptions' AND column_name = 'economic_development_affects_elephant_distribution') THEN
    ALTER TABLE public.section_f_perceptions RENAME COLUMN economic_development_affects_elephant_distribution TO development_affects_distribution;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_f_perceptions' AND column_name = 'agricultural_expansion_reduces_elephant_habitat') THEN
    ALTER TABLE public.section_f_perceptions RENAME COLUMN agricultural_expansion_reduces_elephant_habitat TO agricultural_expansion_reduces_habitat;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'socioeconomic_development_indicators')
    AND NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'section_g_development_indicators') THEN
    ALTER TABLE public.socioeconomic_development_indicators RENAME TO section_g_development_indicators;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_g_development_indicators' AND column_name = 'road_infrastructure_improve') THEN
    ALTER TABLE public.section_g_development_indicators RENAME COLUMN road_infrastructure_improve TO road_infrastructure_change;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_g_development_indicators' AND column_name = 'agricultural_expansion_increase') THEN
    ALTER TABLE public.section_g_development_indicators RENAME COLUMN agricultural_expansion_increase TO agricultural_expansion_change;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_g_development_indicators' AND column_name = 'population_density_increase') THEN
    ALTER TABLE public.section_g_development_indicators RENAME COLUMN population_density_increase TO population_density_change;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_g_development_indicators' AND column_name = 'businesses_or_industries_been_established_nearby') THEN
    ALTER TABLE public.section_g_development_indicators RENAME COLUMN businesses_or_industries_been_established_nearby TO new_business_nearby;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'section_g_development_indicators' AND column_name = 'household_income_improve') THEN
    ALTER TABLE public.section_g_development_indicators RENAME COLUMN household_income_improve TO household_income_change;
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.section_h_community_knowledge (
  survey_id text PRIMARY KEY REFERENCES public.information(survey_id) ON DELETE CASCADE,
  knows_traditional_routes text,
  traditional_route_description text,
  elders_know_routes text,
  community_conservation text,
  community_conservation_description text
);

CREATE TABLE IF NOT EXISTS public.section_j_open_ended_questions (
  survey_id text PRIMARY KEY REFERENCES public.information(survey_id) ON DELETE CASCADE,
  reason_elephants_occur text,
  development_effect_on_movements text,
  conflict_reduction_measures text,
  additional_comments text
);
