function isBlank(value) {
    return typeof value !== "string" || value.trim() === "";
}

function isMissingNumber(value) {
    return value === null || value === "" || Number.isNaN(value);
}

function isValidNumber(value, min = -Infinity, max = Infinity) {
    return !isMissingNumber(value) && value >= min && value <= max;
}

export function validateSurveyForm(form) {
    const errors = [];

    if (isBlank(form.basic.survey_id)) errors.push("Survey ID is required.");
    if (!form.basic.survey_date) errors.push("Survey date is required.");
    if (isBlank(form.basic.enumerator_name)) errors.push("Enumerator name is required.");
    if (isBlank(form.basic.village_name)) errors.push("Village name is required.");
    if (isBlank(form.basic.district)) errors.push("District is required.");
    if (!isValidNumber(form.basic.longitude, -180, 180)) {
        errors.push("Longitude must be between -180 and 180.");
    }
    if (!isValidNumber(form.basic.latitude, -90, 90)) {
        errors.push("Latitude must be between -90 and 90.");
    }

    if (isBlank(form.section_a.gender)) errors.push("Gender is required.");
    if (!isValidNumber(form.section_a.age, 0, 120)) {
        errors.push("Age must be between 0 and 120.");
    }
    if (isBlank(form.section_a.marital_status)) errors.push("Marital status is required.");
    if (isBlank(form.section_a.education_level)) errors.push("Education level is required.");
    if (isBlank(form.section_a.occupation_main)) errors.push("Main occupation is required.");
    if (form.section_a.occupation_main === "Other" && isBlank(form.section_a.occupation_other)) {
        errors.push("Please specify the other occupation.");
    }
    if (!isValidNumber(form.section_a.household_size, 1)) {
        errors.push("Household size must be at least 1.");
    }
    if (!isValidNumber(form.section_a.income_earners, 0)) {
        errors.push("Number of income earners must be 0 or more.");
    }

    if (isBlank(form.section_b.monthly_income_group)) errors.push("Monthly income group is required.");
    if (isBlank(form.section_b.main_income_source)) errors.push("Main income source is required.");
    if (form.section_b.main_income_source === "Other" && isBlank(form.section_b.main_income_source_other)) {
        errors.push("Please specify the other income source.");
    }
    if (form.section_b.owns_agricultural_land === null) {
        errors.push("Please answer whether the household owns agricultural land.");
    }
    if (form.section_b.owns_agricultural_land === true && !isValidNumber(form.section_b.land_area_ha, 0)) {
        errors.push("Land area must be 0 or more when agricultural land is owned.");
    }
    if (form.section_b.land_use_types.includes("Other") && isBlank(form.section_b.land_use_type_other)) {
        errors.push("Please specify the other land use type.");
    }

    if (isBlank(form.section_c.land_use_change_level)) errors.push("Land use change level is required.");
    if (form.section_c.change_types.length === 0) errors.push("At least one observed land use change is required.");
    if (form.section_c.change_types.includes("Other") && isBlank(form.section_c.change_type_other)) {
        errors.push("Please specify the other observed land use change.");
    }
    if (isBlank(form.section_c.distance_home_forest_group)) {
        errors.push("Distance from home to forest is required.");
    }
    if (!isValidNumber(form.section_c.distance_farmland_forest_km, 0)) {
        errors.push("Distance from farmland to forest must be 0 or more.");
    }

    if (form.section_d.seen_elephants === null) {
        errors.push("Please answer whether wild elephants have been seen.");
    }
    if (form.section_d.seen_elephants === true) {
        if (isBlank(form.section_d.elephant_frequency)) errors.push("Elephant appearance frequency is required.");
        if (form.section_d.elephant_common_locations.length === 0) {
            errors.push("At least one common elephant location is required.");
        }
        if (
            form.section_d.elephant_common_locations.includes("Other") &&
            isBlank(form.section_d.elephant_common_location_other)
        ) {
            errors.push("Please specify the other elephant location.");
        }
        if (!isValidNumber(form.section_d.elephant_common_distance_km, 0)) {
            errors.push("Common elephant observation distance must be 0 or more.");
        }
        if (isBlank(form.section_d.elephant_season)) errors.push("Elephant season is required.");
        if (isBlank(form.section_d.herd_size_group)) errors.push("Herd size group is required.");
        if (isBlank(form.section_d.elephant_number_change)) errors.push("Elephant number change is required.");
        if (form.section_d.elephant_route_change === null) {
            errors.push("Please answer whether elephant movement routes changed.");
        }
        if (
            form.section_d.elephant_route_change === true &&
            isBlank(form.section_d.elephant_route_change_explanation)
        ) {
            errors.push("Please explain the elephant route change.");
        }
    }

    if (form.section_e.crop_damage === null) {
        errors.push("Please answer whether elephants damaged crops.");
    }
    if (form.section_e.crop_damage === true) {
        if (isBlank(form.section_e.crop_damage_frequency)) errors.push("Crop damage frequency is required.");
        if (isBlank(form.section_e.economic_loss_group)) errors.push("Economic loss group is required.");
        if (form.section_e.crop_types.length === 0) errors.push("At least one affected crop type is required.");
        if (form.section_e.crop_types.includes("Other") && isBlank(form.section_e.crop_type_other)) {
            errors.push("Please specify the other crop type.");
        }
    }
    if (form.section_e.property_damage === null) errors.push("Please answer whether property was damaged.");
    if (form.section_e.human_injury === null) errors.push("Please answer whether people were injured.");
    if (form.section_e.human_death === null) errors.push("Please answer whether people were killed.");
    if (form.section_e.deterrence_methods.includes("Other") && isBlank(form.section_e.deterrence_method_other)) {
        errors.push("Please specify the other deterrence method.");
    }

    for (const [key, value] of Object.entries(form.section_f)) {
        if (!isValidNumber(value, 1, 5)) {
            errors.push(`Perception item "${key}" must be answered from 1 to 5.`);
        }
    }

    if (isBlank(form.section_g.road_infrastructure_change)) {
        errors.push("Road infrastructure change is required.");
    }
    if (isBlank(form.section_g.agricultural_expansion_change)) {
        errors.push("Agricultural expansion change is required.");
    }
    if (isBlank(form.section_g.population_density_change)) {
        errors.push("Population density change is required.");
    }
    if (form.section_g.new_business_nearby === null) {
        errors.push("Please answer whether new businesses were established nearby.");
    }
    if (isBlank(form.section_g.household_income_change)) {
        errors.push("Household income change is required.");
    }

    if (form.section_h.knows_traditional_routes === null) {
        errors.push("Please answer whether traditional elephant routes are known.");
    }
    if (form.section_h.knows_traditional_routes === true && isBlank(form.section_h.traditional_route_description)) {
        errors.push("Please describe the traditional elephant route location.");
    }
    if (form.section_h.elders_know_routes === null) {
        errors.push("Please answer whether local elders know elephant movements.");
    }
    if (form.section_h.community_conservation === null) {
        errors.push("Please answer whether community conservation activities exist.");
    }
    if (
        form.section_h.community_conservation === true &&
        isBlank(form.section_h.community_conservation_description)
    ) {
        errors.push("Please describe the community conservation activities.");
    }

    if (isBlank(form.section_j.reason_elephants_occur)) {
        errors.push("The main reason elephants occur in this area is required.");
    }
    if (isBlank(form.section_j.development_effect_on_movements)) {
        errors.push("The development effect on elephant movements is required.");
    }
    if (isBlank(form.section_j.conflict_reduction_measures)) {
        errors.push("Conflict reduction measures are required.");
    }

    return errors;
}
