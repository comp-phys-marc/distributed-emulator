--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.10
-- Dumped by pg_dump version 9.6.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: calculation_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.calculation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Calculation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Calculation" (
    id integer DEFAULT nextval('public.calculation_seq'::regclass) NOT NULL,
    user_id integer,
    result text,
    type text
);


--
-- Name: single_phase_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.single_phase_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: SinglePhase; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SinglePhase" (
    id integer DEFAULT nextval('public.single_phase_seq'::regclass) NOT NULL,
    calculation_id integer,
    phase text,
    previous_phase_id integer,
    states text,
    negative_flags text,
    imaginary_flags text
);


--
-- Name: user_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."User" (
    id integer DEFAULT nextval('public.user_seq'::regclass) NOT NULL,
    name text,
    email text,
    password text,
    companyname text,
    phone text
);


--
-- Data for Name: Calculation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Calculation" (id, user_id, result, type) FROM stdin;
\.


--
-- Data for Name: SinglePhase; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."SinglePhase" (id, calculation_id, phase, previous_phase_id, states, negative_flags, imaginary_flags) FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."User" (id, name, email, password, companyname, phone) FROM stdin;
\.


--
-- Name: calculation_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.calculation_seq', 1, false);


--
-- Name: single_phase_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.single_phase_seq', 1, false);


--
-- Name: user_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_seq', 1, false);


--
-- Name: Calculation Calculation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Calculation"
    ADD CONSTRAINT "Calculation_pkey" PRIMARY KEY (id);


--
-- Name: SinglePhase SinglePhase_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SinglePhase"
    ADD CONSTRAINT "SinglePhase_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM cloudsqladmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

