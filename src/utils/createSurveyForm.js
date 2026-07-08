export function createSurveyForm() {
    return {
        basic: {
            survey_id: "",
            survey_date: "",
            enumerator_name: "",
            village_name: "",
            district: "",
            longitude: null,
            latitude: null,
            respondent_code: ""
        },

        section_a: {
            gender: "",
            age: null,
            marital_status: "",
            education_level: "",
            occupation_main: "",
            occupation_other: "",
            household_size: null,
            income_earners: null
        },

        section_b: {
            monthly_income_group: "",
            main_income_source: "",
            main_income_source_other: "",
            owns_agricultural_land: null,
            land_area_ha: null,
            land_use_types: [],
            land_use_type_other: "",
            livestock: {
                cattle: null,
                buffalo: null,
                goat: null,
                sheep: null,
                others: null
            }
        },

        section_c: {
            land_use_change_level: "",
            change_types: [],
            change_type_other: "",
            distance_home_forest_group: "",
            distance_farmland_forest_km: null,
            water_sources: []
        },

        section_d: {
            seen_elephants: null,
            elephant_frequency: "",
            elephant_common_locations: [],
            elephant_common_location_other: "",
            elephant_common_distance_km: null,
            elephant_season: "",
            herd_size_group: "",
            elephant_number_change: "",
            elephant_route_change: null,
            elephant_route_change_explanation: ""
        },

        section_e: {
            crop_damage: null,
            crop_damage_frequency: "",
            economic_loss_group: "",
            crop_types: [],
            crop_type_other: "",
            property_damage: null,
            human_injury: null,
            human_death: null,
            deterrence_methods: [],
            deterrence_method_other: ""
        },

        section_f: {
            elephants_important_ecosystem: null,
            elephant_population_protected: null,
            government_programs_effective: null,
            conflict_increasing: null,
            communities_benefit_conservation: null,
            habitats_preserved: null,
            development_affects_distribution: null,
            agricultural_expansion_reduces_habitat: null
        },

        section_g: {
            road_infrastructure_change: "",
            agricultural_expansion_change: "",
            population_density_change: "",
            new_business_nearby: null,
            household_income_change: ""
        },

        section_h: {
            knows_traditional_routes: null,
            traditional_route_description: "",
            elders_know_routes: null,
            community_conservation: null,
            community_conservation_description: ""
        },

        section_j: {
            reason_elephants_occur: "",
            development_effect_on_movements: "",
            conflict_reduction_measures: "",
            additional_comments: ""
        }
    };
}