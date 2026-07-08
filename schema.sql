--
-- PostgreSQL database dump
--

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-07-08 20:38:34

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 16389)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

-- CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 6050 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

-- COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 245 (class 1259 OID 17687)
-- Name: community_knowledge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.community_knowledge (
    survey_id text NOT NULL,
    traditional_elephant_movement_routes text,
    elders_possess_knowledge text,
    community_based_conservation_activities text,
    the_main_reason_elephants_occur_in_this_area text,
    how_socioeconomic_development_affected_elephant_movements text,
    measures_taken_to_reduce_human_elephant_conflict text,
    additional_comments text
);


ALTER TABLE public.community_knowledge OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17589)
-- Name: elephant_precense_and_distribution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.elephant_precense_and_distribution (
    survey_id text NOT NULL,
    ever_seen_elephant text,
    elephant_appear_frequency text,
    distance_from_center_to_where_observed double precision,
    season_most_observed text,
    typical_herd_size text,
    change_in_elephant_number text,
    change_in_movement_routes text,
    elephant_route_change_explanation text
);


ALTER TABLE public.elephant_precense_and_distribution OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17602)
-- Name: human_elephant_conflict; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.human_elephant_conflict (
    survey_id text NOT NULL,
    damage_crops text,
    frequency_of_damage_crops text,
    estimated_economic_loss_per_year text,
    damage_property text,
    injure_people text,
    kill_people text
);


ALTER TABLE public.human_elephant_conflict OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17471)
-- Name: information; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.information (
    survey_id text NOT NULL,
    survey_date date,
    enumerator_name text,
    village_name text,
    district text,
    gps_coordinates text,
    respondent_code text
);


ALTER TABLE public.information OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17543)
-- Name: landuse_and_environmental_change; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.landuse_and_environmental_change (
    survey_id text NOT NULL,
    change_degree text,
    distance_from_home_to_forest text,
    diatance_from_farmland_to_forest double precision
);


ALTER TABLE public.landuse_and_environmental_change OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17632)
-- Name: methods_deter_elephants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.methods_deter_elephants (
    id integer NOT NULL,
    survey_id text,
    methods_deter_elephants text NOT NULL,
    methods_deter_elephants_other text
);


ALTER TABLE public.methods_deter_elephants OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17631)
-- Name: methods_deter_elephants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.methods_deter_elephants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.methods_deter_elephants_id_seq OWNER TO postgres;

--
-- TOC entry 6051 (class 0 OID 0)
-- Dependencies: 241
-- Name: methods_deter_elephants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.methods_deter_elephants_id_seq OWNED BY public.methods_deter_elephants.id;


--
-- TOC entry 243 (class 1259 OID 17648)
-- Name: perceptions_elephant_conservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perceptions_elephant_conservation (
    survey_id text NOT NULL,
    elephants_important_for_ecosystems text,
    elephant_populations_should_be_protected text,
    government_conservation_programs_are_effective text,
    human_elephant_conflict_is_increasing text,
    local_communities_benefit_from_elephant_conservation text,
    elephant_habitats_should_be_preserved text,
    economic_development_affects_elephant_distribution text,
    agricultural_expansion_reduces_elephant_habitat text
);


ALTER TABLE public.perceptions_elephant_conservation OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17485)
-- Name: respondent_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.respondent_profile (
    survey_id text NOT NULL,
    gender text,
    age integer,
    marital_status text,
    education_level text,
    occupation text,
    household_size integer,
    number_of_income_earners integer
);


ALTER TABLE public.respondent_profile OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17512)
-- Name: section_b_landuse_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.section_b_landuse_types (
    id integer NOT NULL,
    survey_id text,
    landuse_type text NOT NULL,
    landuse_type_other text
);


ALTER TABLE public.section_b_landuse_types OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17511)
-- Name: section_b_landuse_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.section_b_landuse_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.section_b_landuse_types_id_seq OWNER TO postgres;

--
-- TOC entry 6052 (class 0 OID 0)
-- Dependencies: 228
-- Name: section_b_landuse_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.section_b_landuse_types_id_seq OWNED BY public.section_b_landuse_types.id;


--
-- TOC entry 231 (class 1259 OID 17528)
-- Name: section_b_livestock_ownership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.section_b_livestock_ownership (
    id integer NOT NULL,
    survey_id text,
    livestock_type text,
    livestock_number integer,
    CONSTRAINT section_b_livestock_ownership_livestock_number_check CHECK ((livestock_number >= 0))
);


ALTER TABLE public.section_b_livestock_ownership OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17527)
-- Name: section_b_livestock_ownership_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.section_b_livestock_ownership_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.section_b_livestock_ownership_id_seq OWNER TO postgres;

--
-- TOC entry 6053 (class 0 OID 0)
-- Dependencies: 230
-- Name: section_b_livestock_ownership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.section_b_livestock_ownership_id_seq OWNED BY public.section_b_livestock_ownership.id;


--
-- TOC entry 234 (class 1259 OID 17558)
-- Name: section_c_main_observed_changes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.section_c_main_observed_changes (
    id integer NOT NULL,
    survey_id text,
    main_observed_changes text NOT NULL,
    main_observed_changes_other text
);


ALTER TABLE public.section_c_main_observed_changes OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17557)
-- Name: section_c_main_observed_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.section_c_main_observed_changes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.section_c_main_observed_changes_id_seq OWNER TO postgres;

--
-- TOC entry 6054 (class 0 OID 0)
-- Dependencies: 233
-- Name: section_c_main_observed_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.section_c_main_observed_changes_id_seq OWNED BY public.section_c_main_observed_changes.id;


--
-- TOC entry 236 (class 1259 OID 17574)
-- Name: section_c_precense_of_watersources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.section_c_precense_of_watersources (
    id integer NOT NULL,
    survey_id text,
    precense_of_watersources text CONSTRAINT section_c_precense_of_waterso_precense_of_watersources_not_null NOT NULL
);


ALTER TABLE public.section_c_precense_of_watersources OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17573)
-- Name: section_c_precense_of_watersources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.section_c_precense_of_watersources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.section_c_precense_of_watersources_id_seq OWNER TO postgres;

--
-- TOC entry 6055 (class 0 OID 0)
-- Dependencies: 235
-- Name: section_c_precense_of_watersources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.section_c_precense_of_watersources_id_seq OWNED BY public.section_c_precense_of_watersources.id;


--
-- TOC entry 247 (class 1259 OID 17701)
-- Name: section_d_elephant_common_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.section_d_elephant_common_locations (
    id integer NOT NULL,
    survey_id text,
    location_type text NOT NULL,
    location_other text
);


ALTER TABLE public.section_d_elephant_common_locations OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 17700)
-- Name: section_d_elephant_common_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.section_d_elephant_common_locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.section_d_elephant_common_locations_id_seq OWNER TO postgres;

--
-- TOC entry 6056 (class 0 OID 0)
-- Dependencies: 246
-- Name: section_d_elephant_common_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.section_d_elephant_common_locations_id_seq OWNED BY public.section_d_elephant_common_locations.id;


--
-- TOC entry 240 (class 1259 OID 17616)
-- Name: section_e_affected_crop_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.section_e_affected_crop_type (
    id integer NOT NULL,
    survey_id text,
    affected_crop_type text NOT NULL,
    affected_crop_type_other text
);


ALTER TABLE public.section_e_affected_crop_type OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17615)
-- Name: section_e_affected_crop_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.section_e_affected_crop_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.section_e_affected_crop_type_id_seq OWNER TO postgres;

--
-- TOC entry 6057 (class 0 OID 0)
-- Dependencies: 239
-- Name: section_e_affected_crop_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.section_e_affected_crop_type_id_seq OWNED BY public.section_e_affected_crop_type.id;


--
-- TOC entry 227 (class 1259 OID 17498)
-- Name: socioeconomic_characteristic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socioeconomic_characteristic (
    survey_id text NOT NULL,
    average_monthly_household_income text,
    main_income_source text,
    own_agriculture_land boolean,
    area_owned double precision
);


ALTER TABLE public.socioeconomic_characteristic OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17661)
-- Name: socioeconomic_development_indicators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socioeconomic_development_indicators (
    survey_id text NOT NULL,
    road_infrastructure_improve text,
    agricultural_expansion_increase text,
    population_density_increase text,
    businesses_or_industries_been_established_nearby text,
    household_income_improve text
);


ALTER TABLE public.socioeconomic_development_indicators OWNER TO postgres;

--
-- TOC entry 5840 (class 2604 OID 17635)
-- Name: methods_deter_elephants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.methods_deter_elephants ALTER COLUMN id SET DEFAULT nextval('public.methods_deter_elephants_id_seq'::regclass);


--
-- TOC entry 5835 (class 2604 OID 17515)
-- Name: section_b_landuse_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_b_landuse_types ALTER COLUMN id SET DEFAULT nextval('public.section_b_landuse_types_id_seq'::regclass);


--
-- TOC entry 5836 (class 2604 OID 17531)
-- Name: section_b_livestock_ownership id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_b_livestock_ownership ALTER COLUMN id SET DEFAULT nextval('public.section_b_livestock_ownership_id_seq'::regclass);


--
-- TOC entry 5837 (class 2604 OID 17561)
-- Name: section_c_main_observed_changes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_c_main_observed_changes ALTER COLUMN id SET DEFAULT nextval('public.section_c_main_observed_changes_id_seq'::regclass);


--
-- TOC entry 5838 (class 2604 OID 17577)
-- Name: section_c_precense_of_watersources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_c_precense_of_watersources ALTER COLUMN id SET DEFAULT nextval('public.section_c_precense_of_watersources_id_seq'::regclass);


--
-- TOC entry 5841 (class 2604 OID 17704)
-- Name: section_d_elephant_common_locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_d_elephant_common_locations ALTER COLUMN id SET DEFAULT nextval('public.section_d_elephant_common_locations_id_seq'::regclass);


--
-- TOC entry 5839 (class 2604 OID 17619)
-- Name: section_e_affected_crop_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_e_affected_crop_type ALTER COLUMN id SET DEFAULT nextval('public.section_e_affected_crop_type_id_seq'::regclass);


--
-- TOC entry 5875 (class 2606 OID 17694)
-- Name: community_knowledge community_knowledge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_knowledge
    ADD CONSTRAINT community_knowledge_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 5863 (class 2606 OID 17596)
-- Name: elephant_precense_and_distribution elephant_precense_and_distribution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elephant_precense_and_distribution
    ADD CONSTRAINT elephant_precense_and_distribution_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 5865 (class 2606 OID 17609)
-- Name: human_elephant_conflict human_elephant_conflict_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.human_elephant_conflict
    ADD CONSTRAINT human_elephant_conflict_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 5847 (class 2606 OID 17478)
-- Name: information information_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.information
    ADD CONSTRAINT information_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 5857 (class 2606 OID 17550)
-- Name: landuse_and_environmental_change landuse_and_environmental_change_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.landuse_and_environmental_change
    ADD CONSTRAINT landuse_and_environmental_change_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 5869 (class 2606 OID 17641)
-- Name: methods_deter_elephants methods_deter_elephants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.methods_deter_elephants
    ADD CONSTRAINT methods_deter_elephants_pkey PRIMARY KEY (id);


--
-- TOC entry 5871 (class 2606 OID 17655)
-- Name: perceptions_elephant_conservation perceptions_elephant_conservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perceptions_elephant_conservation
    ADD CONSTRAINT perceptions_elephant_conservation_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 5849 (class 2606 OID 17492)
-- Name: respondent_profile respondent_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respondent_profile
    ADD CONSTRAINT respondent_profile_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 5853 (class 2606 OID 17521)
-- Name: section_b_landuse_types section_b_landuse_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_b_landuse_types
    ADD CONSTRAINT section_b_landuse_types_pkey PRIMARY KEY (id);


--
-- TOC entry 5855 (class 2606 OID 17537)
-- Name: section_b_livestock_ownership section_b_livestock_ownership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_b_livestock_ownership
    ADD CONSTRAINT section_b_livestock_ownership_pkey PRIMARY KEY (id);


--
-- TOC entry 5859 (class 2606 OID 17567)
-- Name: section_c_main_observed_changes section_c_main_observed_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_c_main_observed_changes
    ADD CONSTRAINT section_c_main_observed_changes_pkey PRIMARY KEY (id);


--
-- TOC entry 5861 (class 2606 OID 17583)
-- Name: section_c_precense_of_watersources section_c_precense_of_watersources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_c_precense_of_watersources
    ADD CONSTRAINT section_c_precense_of_watersources_pkey PRIMARY KEY (id);


--
-- TOC entry 5877 (class 2606 OID 17710)
-- Name: section_d_elephant_common_locations section_d_elephant_common_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_d_elephant_common_locations
    ADD CONSTRAINT section_d_elephant_common_locations_pkey PRIMARY KEY (id);


--
-- TOC entry 5867 (class 2606 OID 17625)
-- Name: section_e_affected_crop_type section_e_affected_crop_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_e_affected_crop_type
    ADD CONSTRAINT section_e_affected_crop_type_pkey PRIMARY KEY (id);


--
-- TOC entry 5851 (class 2606 OID 17505)
-- Name: socioeconomic_characteristic socioeconomic_characteristic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socioeconomic_characteristic
    ADD CONSTRAINT socioeconomic_characteristic_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 5873 (class 2606 OID 17668)
-- Name: socioeconomic_development_indicators socioeconomic_development_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socioeconomic_development_indicators
    ADD CONSTRAINT socioeconomic_development_indicators_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 5891 (class 2606 OID 17695)
-- Name: community_knowledge community_knowledge_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_knowledge
    ADD CONSTRAINT community_knowledge_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5885 (class 2606 OID 17597)
-- Name: elephant_precense_and_distribution elephant_precense_and_distribution_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elephant_precense_and_distribution
    ADD CONSTRAINT elephant_precense_and_distribution_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5886 (class 2606 OID 17610)
-- Name: human_elephant_conflict human_elephant_conflict_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.human_elephant_conflict
    ADD CONSTRAINT human_elephant_conflict_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5882 (class 2606 OID 17551)
-- Name: landuse_and_environmental_change landuse_and_environmental_change_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.landuse_and_environmental_change
    ADD CONSTRAINT landuse_and_environmental_change_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5888 (class 2606 OID 17642)
-- Name: methods_deter_elephants methods_deter_elephants_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.methods_deter_elephants
    ADD CONSTRAINT methods_deter_elephants_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5889 (class 2606 OID 17656)
-- Name: perceptions_elephant_conservation perceptions_elephant_conservation_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perceptions_elephant_conservation
    ADD CONSTRAINT perceptions_elephant_conservation_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5878 (class 2606 OID 17493)
-- Name: respondent_profile respondent_profile_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respondent_profile
    ADD CONSTRAINT respondent_profile_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5880 (class 2606 OID 17522)
-- Name: section_b_landuse_types section_b_landuse_types_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_b_landuse_types
    ADD CONSTRAINT section_b_landuse_types_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5881 (class 2606 OID 17538)
-- Name: section_b_livestock_ownership section_b_livestock_ownership_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_b_livestock_ownership
    ADD CONSTRAINT section_b_livestock_ownership_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5883 (class 2606 OID 17568)
-- Name: section_c_main_observed_changes section_c_main_observed_changes_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_c_main_observed_changes
    ADD CONSTRAINT section_c_main_observed_changes_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5884 (class 2606 OID 17584)
-- Name: section_c_precense_of_watersources section_c_precense_of_watersources_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_c_precense_of_watersources
    ADD CONSTRAINT section_c_precense_of_watersources_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5892 (class 2606 OID 17711)
-- Name: section_d_elephant_common_locations section_d_elephant_common_locations_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_d_elephant_common_locations
    ADD CONSTRAINT section_d_elephant_common_locations_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5887 (class 2606 OID 17626)
-- Name: section_e_affected_crop_type section_e_affected_crop_type_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section_e_affected_crop_type
    ADD CONSTRAINT section_e_affected_crop_type_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5879 (class 2606 OID 17506)
-- Name: socioeconomic_characteristic socioeconomic_characteristic_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socioeconomic_characteristic
    ADD CONSTRAINT socioeconomic_characteristic_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


--
-- TOC entry 5890 (class 2606 OID 17669)
-- Name: socioeconomic_development_indicators socioeconomic_development_indicators_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socioeconomic_development_indicators
    ADD CONSTRAINT socioeconomic_development_indicators_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.information(survey_id) ON DELETE CASCADE;


-- Completed on 2026-07-08 20:38:34

--
-- PostgreSQL database dump complete
--
