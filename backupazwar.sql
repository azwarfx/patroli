--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.15
-- Dumped by pg_dump version 9.5.15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: insertpatrol(); Type: FUNCTION; Schema: public; Owner: alamsutera
--

CREATE FUNCTION public.insertpatrol() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    INSERT INTO patrol_cluster(unique_key, guard_id, track_id, start_patrol, end_patrol, created_at, updated_at) 
            VALUES (new.unique_key, new.guard_id, new.track_id, new.created_at, new.created_at, new.created_at, new.created_at)
	ON CONFLICT (unique_key) 
	DO
	UPDATE SET end_patrol = new.created_at where patrol_cluster.unique_key = new.unique_key;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.insertpatrol() OWNER TO alamsutera;

--
-- Name: cluster_area_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.cluster_area_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cluster_area_seq OWNER TO alamsutera;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cluster_area; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.cluster_area (
    id integer DEFAULT nextval('public.cluster_area_seq'::regclass) NOT NULL,
    cluster_id character varying(5),
    latitude character varying(50),
    updated_at timestamp without time zone,
    created_at timestamp without time zone,
    longitude character varying(50)
);


ALTER TABLE public.cluster_area OWNER TO alamsutera;

--
-- Name: cluster_guard_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.cluster_guard_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cluster_guard_seq OWNER TO alamsutera;

--
-- Name: cluster_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.cluster_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cluster_seq OWNER TO alamsutera;

--
-- Name: clusters; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.clusters (
    id integer DEFAULT nextval('public.cluster_seq'::regclass) NOT NULL,
    name character varying(150),
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    code character varying(10),
    latitude character varying(25),
    longitude character varying(25)
);


ALTER TABLE public.clusters OWNER TO alamsutera;

--
-- Name: guard_cluster; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.guard_cluster (
    id bigint DEFAULT nextval('public.cluster_guard_seq'::regclass) NOT NULL,
    guard_id character varying(5),
    cluster_id character varying(5),
    updated_at timestamp without time zone,
    created_at timestamp without time zone
);


ALTER TABLE public.guard_cluster OWNER TO alamsutera;

--
-- Name: personal_track_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.personal_track_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_track_seq OWNER TO alamsutera;

--
-- Name: guard_schedule deleted; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public."guard_schedule deleted" (
    id integer DEFAULT nextval('public.personal_track_seq'::regclass) NOT NULL,
    guard_username character varying(10),
    track_code character varying(10),
    assign_date timestamp without time zone,
    shift_id character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public."guard_schedule deleted" OWNER TO alamsutera;

--
-- Name: personal_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.personal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_seq OWNER TO alamsutera;

--
-- Name: guards; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.guards (
    id integer DEFAULT nextval('public.personal_seq'::regclass) NOT NULL,
    name character varying(30),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    username character varying(100),
    password character varying(100)
);


ALTER TABLE public.guards OWNER TO alamsutera;

--
-- Name: login_session_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.login_session_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_session_seq OWNER TO alamsutera;

--
-- Name: login_session; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.login_session (
    userid character varying(30),
    latest_activities timestamp without time zone,
    cluster_id character varying(30),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    id integer DEFAULT nextval('public.login_session_seq'::regclass) NOT NULL,
    uid character varying(50)
);


ALTER TABLE public.login_session OWNER TO alamsutera;

--
-- Name: panic_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.panic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.panic_seq OWNER TO alamsutera;

--
-- Name: panics; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.panics (
    id bigint DEFAULT nextval('public.panic_seq'::regclass) NOT NULL,
    username character varying(100),
    filename character varying(100),
    latitude character varying(20),
    longitude character varying(20),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    accuracy character varying(100),
    status smallint DEFAULT 0,
    type character varying(1),
    device_datetime timestamp without time zone,
    cluster character varying(200),
    description character varying(200),
    solved_datetime timestamp without time zone
);


ALTER TABLE public.panics OWNER TO alamsutera;

--
-- Name: patrol_cluster_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.patrol_cluster_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patrol_cluster_seq OWNER TO alamsutera;

--
-- Name: patrol_cluster; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.patrol_cluster (
    unique_key character varying(100) NOT NULL,
    track_id character varying(10),
    start_patrol timestamp without time zone,
    guard_id character varying(5),
    end_patrol timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    id bigint DEFAULT nextval('public.patrol_cluster_seq'::regclass)
);


ALTER TABLE public.patrol_cluster OWNER TO alamsutera;

--
-- Name: patrol_seq_id; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.patrol_seq_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patrol_seq_id OWNER TO alamsutera;

--
-- Name: patrols; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.patrols (
    id bigint DEFAULT nextval('public.patrol_seq_id'::regclass) NOT NULL,
    guard_id character(10),
    cluster_code character(10),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    shift_id character varying(1),
    start_at timestamp without time zone,
    finish_at timestamp without time zone
);


ALTER TABLE public.patrols OWNER TO alamsutera;

--
-- Name: polygon_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.polygon_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polygon_seq OWNER TO alamsutera;

--
-- Name: polygon; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.polygon (
    id bigint DEFAULT nextval('public.polygon_seq'::regclass) NOT NULL,
    cluster_code character varying(25),
    track_code character varying(25),
    longitude character varying(25),
    latitude character varying(25)
);


ALTER TABLE public.polygon OWNER TO alamsutera;

--
-- Name: report_id_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_id_seq OWNER TO alamsutera;

--
-- Name: report_accidents; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.report_accidents (
    id bigint DEFAULT nextval('public.report_id_seq'::regclass) NOT NULL,
    title character varying(300),
    description text,
    cluster_id character varying(10),
    guard_id character varying(10),
    shift_id character varying(2),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    photo character varying(200),
    video character varying(200),
    longitude character varying(200),
    latitude character varying(200),
    status character varying(1) DEFAULT 0
);


ALTER TABLE public.report_accidents OWNER TO alamsutera;

--
-- Name: resident_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.resident_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resident_seq OWNER TO alamsutera;

--
-- Name: residents; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.residents (
    id integer DEFAULT nextval('public.resident_seq'::regclass) NOT NULL,
    name character varying(50),
    cluster character varying(50),
    address text,
    phone_number character varying(25),
    email character varying(50),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    cluster_id character varying(15),
    status character varying(1),
    password character varying(100),
    token character varying(100),
    forgot_token character varying(100)
);


ALTER TABLE public.residents OWNER TO alamsutera;

--
-- Name: schedule_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.schedule_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_seq OWNER TO alamsutera;

--
-- Name: shift; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.shift (
    name character varying(30),
    description text,
    start_at time without time zone,
    end_at time without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    id integer DEFAULT nextval('public.schedule_seq'::regclass)
);


ALTER TABLE public.shift OWNER TO alamsutera;

--
-- Name: temp_id_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.temp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temp_id_seq OWNER TO alamsutera;

--
-- Name: track_checkpoint_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.track_checkpoint_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.track_checkpoint_seq OWNER TO alamsutera;

--
-- Name: track_checkpoint; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.track_checkpoint (
    id integer DEFAULT nextval('public.track_checkpoint_seq'::regclass) NOT NULL,
    track_id character varying(15),
    latitude character varying(25),
    longitude character varying(25),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    next_checkpoint_id character varying(15),
    point_order smallint,
    description text,
    beacon_id text
);


ALTER TABLE public.track_checkpoint OWNER TO alamsutera;

--
-- Name: track_coordinates_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.track_coordinates_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.track_coordinates_seq OWNER TO alamsutera;

--
-- Name: track_coordinates; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.track_coordinates (
    id integer DEFAULT nextval('public.track_coordinates_seq'::regclass) NOT NULL,
    track_id character varying(15),
    latitude character varying(25),
    longitude character varying(25),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    point_order smallint
);


ALTER TABLE public.track_coordinates OWNER TO alamsutera;

--
-- Name: tracking_data; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.tracking_data (
    id bigint DEFAULT nextval('public.temp_id_seq'::regclass) NOT NULL,
    track_id character varying(10),
    longitude character varying(50),
    latitude character varying(50),
    created_at timestamp without time zone,
    unique_key character varying(100),
    updated_at timestamp without time zone,
    accuracy character varying(30),
    speed character varying(30),
    device_date timestamp without time zone,
    shift_id character varying(9),
    guard_id character varying(5)
);


ALTER TABLE public.tracking_data OWNER TO alamsutera;

--
-- Name: tracks_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.tracks_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tracks_seq OWNER TO alamsutera;

--
-- Name: tracks; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.tracks (
    id integer DEFAULT nextval('public.tracks_seq'::regclass) NOT NULL,
    code character varying(15),
    name character varying(300),
    cluster_id character varying(15),
    updated_at timestamp without time zone,
    created_at timestamp without time zone
);


ALTER TABLE public.tracks OWNER TO alamsutera;

--
-- Name: users_seq; Type: SEQUENCE; Schema: public; Owner: alamsutera
--

CREATE SEQUENCE public.users_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_seq OWNER TO alamsutera;

--
-- Name: users; Type: TABLE; Schema: public; Owner: alamsutera
--

CREATE TABLE public.users (
    id integer DEFAULT nextval('public.users_seq'::regclass) NOT NULL,
    name character varying(25),
    email character varying(80),
    image character varying(50),
    created_by character varying(1),
    privilege character varying(1),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    password character varying(80),
    remember_token character varying(100),
    cluster_id character varying(5)
);


ALTER TABLE public.users OWNER TO alamsutera;

--
-- Name: cluster_area_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.cluster_area
    ADD CONSTRAINT cluster_area_pkey PRIMARY KEY (id);


--
-- Name: cluster_guard_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.guard_cluster
    ADD CONSTRAINT cluster_guard_pkey PRIMARY KEY (id);


--
-- Name: clusters_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT clusters_pkey PRIMARY KEY (id);


--
-- Name: login_session_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.login_session
    ADD CONSTRAINT login_session_pkey PRIMARY KEY (id);


--
-- Name: panic_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.panics
    ADD CONSTRAINT panic_pkey PRIMARY KEY (id);


--
-- Name: patrol_cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.patrol_cluster
    ADD CONSTRAINT patrol_cluster_pkey PRIMARY KEY (unique_key);


--
-- Name: patrols_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.patrols
    ADD CONSTRAINT patrols_pkey PRIMARY KEY (id);


--
-- Name: personal_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.guards
    ADD CONSTRAINT personal_pkey PRIMARY KEY (id);


--
-- Name: personal_track_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public."guard_schedule deleted"
    ADD CONSTRAINT personal_track_pkey PRIMARY KEY (id);


--
-- Name: polygon_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.polygon
    ADD CONSTRAINT polygon_pkey PRIMARY KEY (id);


--
-- Name: report_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.report_accidents
    ADD CONSTRAINT report_pkey PRIMARY KEY (id);


--
-- Name: residents_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.residents
    ADD CONSTRAINT residents_pkey PRIMARY KEY (id);


--
-- Name: route_coordinate_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.track_coordinates
    ADD CONSTRAINT route_coordinate_pkey PRIMARY KEY (id);


--
-- Name: routes_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.tracks
    ADD CONSTRAINT routes_pkey PRIMARY KEY (id);


--
-- Name: temp_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.tracking_data
    ADD CONSTRAINT temp_pkey PRIMARY KEY (id);


--
-- Name: track_checkpoint_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.track_checkpoint
    ADD CONSTRAINT track_checkpoint_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: alamsutera
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_created_at; Type: INDEX; Schema: public; Owner: alamsutera
--

CREATE INDEX index_created_at ON public.tracking_data USING btree (created_at);


--
-- Name: index_track_id; Type: INDEX; Schema: public; Owner: alamsutera
--

CREATE INDEX index_track_id ON public.tracking_data USING btree (track_id);


--
-- Name: index_unique_key; Type: INDEX; Schema: public; Owner: alamsutera
--

CREATE INDEX index_unique_key ON public.tracking_data USING btree (unique_key);


--
-- Name: unique_created_track; Type: INDEX; Schema: public; Owner: alamsutera
--

CREATE INDEX unique_created_track ON public.tracking_data USING btree (unique_key, created_at DESC NULLS LAST, track_id);


--
-- Name: insert_into_patrol_cluster; Type: TRIGGER; Schema: public; Owner: alamsutera
--

CREATE TRIGGER insert_into_patrol_cluster AFTER INSERT ON public.tracking_data FOR EACH ROW EXECUTE PROCEDURE public.insertpatrol();


--
-- Name: trigger_insert; Type: TRIGGER; Schema: public; Owner: alamsutera
--

CREATE TRIGGER trigger_insert AFTER INSERT ON public.patrol_cluster FOR EACH ROW EXECUTE PROCEDURE public.insertpatrol();


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

