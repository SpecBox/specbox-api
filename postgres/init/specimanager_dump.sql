--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: all_taxa; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.all_taxa (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    kingdom character varying(30) NOT NULL,
    phylum character varying(30) NOT NULL,
    class_name character varying(30) NOT NULL,
    "order" character varying(30) NOT NULL,
    suborder character varying(30) NOT NULL,
    family character varying(30) NOT NULL,
    subfamily character varying(30) NOT NULL,
    tribe character varying(30) NOT NULL,
    subtribe character varying(30) NOT NULL,
    genus character varying(30) NOT NULL,
    subgenus character varying(30) NOT NULL,
    species character varying(30) NOT NULL,
    subspecies character varying(30) NOT NULL,
    scientific_name_author character varying(50) NOT NULL,
    name_publishedin_year integer NOT NULL,
    japanese_name character varying(30) NOT NULL,
    distribution character varying(500) NOT NULL,
    note text NOT NULL,
    image1 character varying(100),
    image2 character varying(100),
    image3 character varying(100),
    image4 character varying(100),
    image5 character varying(100),
    change_genus_brackets boolean NOT NULL,
    unknown_author_brackets boolean NOT NULL,
    unknown_name_publishedin_year_brackets boolean NOT NULL,
    actual_dist_year integer NOT NULL
);


ALTER TABLE public.all_taxa OWNER TO lucky;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO lucky;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO lucky;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO lucky;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO lucky;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO lucky;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO lucky;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO lucky;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO lucky;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO lucky;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO lucky;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO lucky;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO lucky;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: collect_points; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.collect_points (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    contient character varying(20) NOT NULL,
    island_group character varying(30) NOT NULL,
    island character varying(24) NOT NULL,
    country character varying(2) NOT NULL,
    state_provice character varying(30) NOT NULL,
    county character varying(30) NOT NULL,
    municipality character varying(50) NOT NULL,
    verbatim_locality text NOT NULL,
    japanese_place_name character varying(14) NOT NULL,
    japanese_place_name_detail character varying(50) NOT NULL,
    coordinate_precision double precision NOT NULL,
    location public.geography(Point,4326) NOT NULL,
    minimum_elevation double precision NOT NULL,
    maximum_elevation double precision NOT NULL,
    minimum_depth double precision NOT NULL,
    maximum_depth double precision NOT NULL,
    note text NOT NULL,
    image1 character varying(100),
    image2 character varying(100),
    image3 character varying(100),
    image4 character varying(100),
    image5 character varying(100),
    user_id integer
);


ALTER TABLE public.collect_points OWNER TO lucky;

--
-- Name: collect_points_tour; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.collect_points_tour (
    id integer NOT NULL,
    collectpoint_id uuid NOT NULL,
    tour_id uuid NOT NULL
);


ALTER TABLE public.collect_points_tour OWNER TO lucky;

--
-- Name: collect_points_tour_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.collect_points_tour_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collect_points_tour_id_seq OWNER TO lucky;

--
-- Name: collect_points_tour_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.collect_points_tour_id_seq OWNED BY public.collect_points_tour.id;


--
-- Name: collection_settings; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.collection_settings (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    collection_name character varying(174) NOT NULL,
    institution_code character varying(10) NOT NULL,
    latest_collection_code integer NOT NULL,
    note text NOT NULL,
    user_id integer
);


ALTER TABLE public.collection_settings OWNER TO lucky;

--
-- Name: custom_taxa; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.custom_taxa (
    taxon_ptr_id uuid NOT NULL,
    is_private boolean NOT NULL,
    user_id integer
);


ALTER TABLE public.custom_taxa OWNER TO lucky;

--
-- Name: default_taxa; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.default_taxa (
    taxon_ptr_id uuid NOT NULL,
    is_private boolean NOT NULL
);


ALTER TABLE public.default_taxa OWNER TO lucky;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO lucky;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO lucky;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO lucky;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO lucky;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO lucky;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO lucky;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO lucky;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.migrations (
    id bigint NOT NULL,
    version bigint NOT NULL
);


ALTER TABLE public.migrations OWNER TO lucky;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO lucky;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: specimen_labels; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.specimen_labels (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    name character varying(30) NOT NULL,
    data_label_flag boolean NOT NULL,
    coll_label_flag boolean NOT NULL,
    det_label_flag boolean NOT NULL,
    note_label_flag boolean NOT NULL,
    user_id integer
);


ALTER TABLE public.specimen_labels OWNER TO lucky;

--
-- Name: specimen_labels_label_specimens; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.specimen_labels_label_specimens (
    id integer NOT NULL,
    specimenlabel_id uuid NOT NULL,
    specimen_id uuid NOT NULL
);


ALTER TABLE public.specimen_labels_label_specimens OWNER TO lucky;

--
-- Name: specimen_labels_label_specimens_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.specimen_labels_label_specimens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.specimen_labels_label_specimens_id_seq OWNER TO lucky;

--
-- Name: specimen_labels_label_specimens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.specimen_labels_label_specimens_id_seq OWNED BY public.specimen_labels_label_specimens.id;


--
-- Name: specimens; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.specimens (
    id uuid NOT NULL,
    date_last_modified timestamp with time zone NOT NULL,
    collection_code integer NOT NULL,
    identified_by character varying(18) NOT NULL,
    date_identified date NOT NULL,
    collecter character varying(18) NOT NULL,
    year integer NOT NULL,
    month integer NOT NULL,
    day integer NOT NULL,
    sex character varying(1) NOT NULL,
    preparation_type character varying(20) NOT NULL,
    disposition character varying(30) NOT NULL,
    sampling_protocol character varying(20) NOT NULL,
    sampling_effort text NOT NULL,
    lifestage character varying(20) NOT NULL,
    establishment_means character varying(20) NOT NULL,
    rights character varying(10) NOT NULL,
    note text NOT NULL,
    image1 character varying(100),
    image2 character varying(100),
    image3 character varying(100),
    image4 character varying(100),
    image5 character varying(100),
    collect_point_info_id uuid,
    collection_settings_info_id uuid,
    custom_taxon_info_id uuid,
    default_taxon_info_id uuid,
    tour_id uuid,
    user_id integer,
    allow_kojin_shuzo boolean NOT NULL,
    published_kojin_shuzo boolean NOT NULL
);


ALTER TABLE public.specimens OWNER TO lucky;

--
-- Name: tours; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.tours (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    title character varying(30) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    track public.geography(LineString,4326),
    note text NOT NULL,
    image1 character varying(100),
    image2 character varying(100),
    image3 character varying(100),
    image4 character varying(100),
    image5 character varying(100),
    user_id integer
);


ALTER TABLE public.tours OWNER TO lucky;

--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.user_profiles (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    contient character varying(20) NOT NULL,
    island_group character varying(30) NOT NULL,
    island character varying(24) NOT NULL,
    country character varying(2) NOT NULL,
    state_provice character varying(30) NOT NULL,
    identified_by character varying(19) NOT NULL,
    collecter character varying(18) NOT NULL,
    preparation_type character varying(20) NOT NULL,
    disposition character varying(30) NOT NULL,
    lifestage character varying(20) NOT NULL,
    establishment_means character varying(20) NOT NULL,
    rights character varying(10) NOT NULL,
    kingdom character varying(30) NOT NULL,
    phylum character varying(30) NOT NULL,
    class_name character varying(30) NOT NULL,
    "order" character varying(30) NOT NULL,
    user_id integer
);


ALTER TABLE public.user_profiles OWNER TO lucky;

--
-- Name: users; Type: TABLE; Schema: public; Owner: lucky
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    email public.citext NOT NULL,
    encrypted_password text NOT NULL
);


ALTER TABLE public.users OWNER TO lucky;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: lucky
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO lucky;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lucky
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: collect_points_tour id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.collect_points_tour ALTER COLUMN id SET DEFAULT nextval('public.collect_points_tour_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: specimen_labels_label_specimens id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimen_labels_label_specimens ALTER COLUMN id SET DEFAULT nextval('public.specimen_labels_label_specimens_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: all_taxa all_taxa_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.all_taxa
    ADD CONSTRAINT all_taxa_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: collect_points collect_points_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.collect_points
    ADD CONSTRAINT collect_points_pkey PRIMARY KEY (id);


--
-- Name: collect_points_tour collect_points_tour_collectpoint_id_tour_id_7c17bf1d_uniq; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.collect_points_tour
    ADD CONSTRAINT collect_points_tour_collectpoint_id_tour_id_7c17bf1d_uniq UNIQUE (collectpoint_id, tour_id);


--
-- Name: collect_points_tour collect_points_tour_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.collect_points_tour
    ADD CONSTRAINT collect_points_tour_pkey PRIMARY KEY (id);


--
-- Name: collection_settings collection_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.collection_settings
    ADD CONSTRAINT collection_settings_pkey PRIMARY KEY (id);


--
-- Name: custom_taxa custom_taxa_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.custom_taxa
    ADD CONSTRAINT custom_taxa_pkey PRIMARY KEY (taxon_ptr_id);


--
-- Name: default_taxa default_taxa_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.default_taxa
    ADD CONSTRAINT default_taxa_pkey PRIMARY KEY (taxon_ptr_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: specimen_labels_label_specimens specimen_labels_label_sp_specimenlabel_id_specime_ec0a5d9f_uniq; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimen_labels_label_specimens
    ADD CONSTRAINT specimen_labels_label_sp_specimenlabel_id_specime_ec0a5d9f_uniq UNIQUE (specimenlabel_id, specimen_id);


--
-- Name: specimen_labels_label_specimens specimen_labels_label_specimens_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimen_labels_label_specimens
    ADD CONSTRAINT specimen_labels_label_specimens_pkey PRIMARY KEY (id);


--
-- Name: specimen_labels specimen_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimen_labels
    ADD CONSTRAINT specimen_labels_pkey PRIMARY KEY (id);


--
-- Name: specimens specimens_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimens
    ADD CONSTRAINT specimens_pkey PRIMARY KEY (id);


--
-- Name: tours tours_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_pkey PRIMARY KEY (id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: collect_points_location_id; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX collect_points_location_id ON public.collect_points USING gist (location);


--
-- Name: collect_points_tour_collectpoint_id_f5ae5bdf; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX collect_points_tour_collectpoint_id_f5ae5bdf ON public.collect_points_tour USING btree (collectpoint_id);


--
-- Name: collect_points_tour_tour_id_918738ef; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX collect_points_tour_tour_id_918738ef ON public.collect_points_tour USING btree (tour_id);


--
-- Name: collect_points_user_id_703b22e9; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX collect_points_user_id_703b22e9 ON public.collect_points USING btree (user_id);


--
-- Name: collection_settings_user_id_a53a3b72; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX collection_settings_user_id_a53a3b72 ON public.collection_settings USING btree (user_id);


--
-- Name: custom_taxa_user_id_a173fd51; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX custom_taxa_user_id_a173fd51 ON public.custom_taxa USING btree (user_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: migrations_version_index; Type: INDEX; Schema: public; Owner: lucky
--

CREATE UNIQUE INDEX migrations_version_index ON public.migrations USING btree (version);


--
-- Name: specimen_labels_label_specimens_specimen_id_856421f1; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX specimen_labels_label_specimens_specimen_id_856421f1 ON public.specimen_labels_label_specimens USING btree (specimen_id);


--
-- Name: specimen_labels_label_specimens_specimenlabel_id_ca839f7e; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX specimen_labels_label_specimens_specimenlabel_id_ca839f7e ON public.specimen_labels_label_specimens USING btree (specimenlabel_id);


--
-- Name: specimen_labels_user_id_c3656e70; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX specimen_labels_user_id_c3656e70 ON public.specimen_labels USING btree (user_id);


--
-- Name: specimens_collect_point_info_id_6be0fbc5; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX specimens_collect_point_info_id_6be0fbc5 ON public.specimens USING btree (collect_point_info_id);


--
-- Name: specimens_collection_settings_info_id_fb09849f; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX specimens_collection_settings_info_id_fb09849f ON public.specimens USING btree (collection_settings_info_id);


--
-- Name: specimens_custom_taxon_info_id_bbee011b; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX specimens_custom_taxon_info_id_bbee011b ON public.specimens USING btree (custom_taxon_info_id);


--
-- Name: specimens_default_taxon_info_id_a610fe3b; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX specimens_default_taxon_info_id_a610fe3b ON public.specimens USING btree (default_taxon_info_id);


--
-- Name: specimens_tour_id_41cb13e4; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX specimens_tour_id_41cb13e4 ON public.specimens USING btree (tour_id);


--
-- Name: specimens_user_id_c7d6bf28; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX specimens_user_id_c7d6bf28 ON public.specimens USING btree (user_id);


--
-- Name: tours_track_id; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX tours_track_id ON public.tours USING gist (track);


--
-- Name: tours_user_id_f66f4e85; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX tours_user_id_f66f4e85 ON public.tours USING btree (user_id);


--
-- Name: user_profiles_user_id_8c5ab5fe; Type: INDEX; Schema: public; Owner: lucky
--

CREATE INDEX user_profiles_user_id_8c5ab5fe ON public.user_profiles USING btree (user_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: lucky
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: collect_points_tour collect_points_tour_collectpoint_id_f5ae5bdf_fk_collect_p; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.collect_points_tour
    ADD CONSTRAINT collect_points_tour_collectpoint_id_f5ae5bdf_fk_collect_p FOREIGN KEY (collectpoint_id) REFERENCES public.collect_points(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: collect_points_tour collect_points_tour_tour_id_918738ef_fk_tours_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.collect_points_tour
    ADD CONSTRAINT collect_points_tour_tour_id_918738ef_fk_tours_id FOREIGN KEY (tour_id) REFERENCES public.tours(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: collect_points collect_points_user_id_703b22e9_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.collect_points
    ADD CONSTRAINT collect_points_user_id_703b22e9_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: collection_settings collection_settings_user_id_a53a3b72_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.collection_settings
    ADD CONSTRAINT collection_settings_user_id_a53a3b72_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_taxa custom_taxa_taxon_ptr_id_68d49116_fk_all_taxa_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.custom_taxa
    ADD CONSTRAINT custom_taxa_taxon_ptr_id_68d49116_fk_all_taxa_id FOREIGN KEY (taxon_ptr_id) REFERENCES public.all_taxa(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_taxa custom_taxa_user_id_a173fd51_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.custom_taxa
    ADD CONSTRAINT custom_taxa_user_id_a173fd51_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: default_taxa default_taxa_taxon_ptr_id_18b91e6f_fk_all_taxa_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.default_taxa
    ADD CONSTRAINT default_taxa_taxon_ptr_id_18b91e6f_fk_all_taxa_id FOREIGN KEY (taxon_ptr_id) REFERENCES public.all_taxa(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: specimen_labels_label_specimens specimen_labels_labe_specimen_id_856421f1_fk_specimens; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimen_labels_label_specimens
    ADD CONSTRAINT specimen_labels_labe_specimen_id_856421f1_fk_specimens FOREIGN KEY (specimen_id) REFERENCES public.specimens(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: specimen_labels_label_specimens specimen_labels_labe_specimenlabel_id_ca839f7e_fk_specimen_; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimen_labels_label_specimens
    ADD CONSTRAINT specimen_labels_labe_specimenlabel_id_ca839f7e_fk_specimen_ FOREIGN KEY (specimenlabel_id) REFERENCES public.specimen_labels(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: specimen_labels specimen_labels_user_id_c3656e70_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimen_labels
    ADD CONSTRAINT specimen_labels_user_id_c3656e70_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: specimens specimens_collect_point_info_id_6be0fbc5_fk_collect_points_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimens
    ADD CONSTRAINT specimens_collect_point_info_id_6be0fbc5_fk_collect_points_id FOREIGN KEY (collect_point_info_id) REFERENCES public.collect_points(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: specimens specimens_collection_settings__fb09849f_fk_collectio; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimens
    ADD CONSTRAINT specimens_collection_settings__fb09849f_fk_collectio FOREIGN KEY (collection_settings_info_id) REFERENCES public.collection_settings(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: specimens specimens_custom_taxon_info_id_bbee011b_fk_custom_ta; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimens
    ADD CONSTRAINT specimens_custom_taxon_info_id_bbee011b_fk_custom_ta FOREIGN KEY (custom_taxon_info_id) REFERENCES public.custom_taxa(taxon_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: specimens specimens_default_taxon_info_i_a610fe3b_fk_default_t; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimens
    ADD CONSTRAINT specimens_default_taxon_info_i_a610fe3b_fk_default_t FOREIGN KEY (default_taxon_info_id) REFERENCES public.default_taxa(taxon_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: specimens specimens_tour_id_41cb13e4_fk_tours_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimens
    ADD CONSTRAINT specimens_tour_id_41cb13e4_fk_tours_id FOREIGN KEY (tour_id) REFERENCES public.tours(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: specimens specimens_user_id_c7d6bf28_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.specimens
    ADD CONSTRAINT specimens_user_id_c7d6bf28_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tours tours_user_id_f66f4e85_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_user_id_f66f4e85_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_profiles user_profiles_user_id_8c5ab5fe_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lucky
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_user_id_8c5ab5fe_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO lucky;


--
-- PostgreSQL database dump complete
--

