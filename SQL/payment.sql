--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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
-- Name: payment; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA payment;


ALTER SCHEMA payment OWNER TO postgres;

--
-- Name: users; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA users;


ALTER SCHEMA users OWNER TO postgres;

--
-- Name: trpa_type; Type: TYPE; Schema: payment; Owner: postgres
--

CREATE TYPE payment.trpa_type AS ENUM (
    'topup',
    'transfer',
    'order',
    'refund'
);


ALTER TYPE payment.trpa_type OWNER TO postgres;

--
-- Name: usac_status; Type: TYPE; Schema: payment; Owner: postgres
--

CREATE TYPE payment.usac_status AS ENUM (
    'active',
    'inactive',
    'blokir'
);


ALTER TYPE payment.usac_status OWNER TO postgres;

--
-- Name: usac_type; Type: TYPE; Schema: payment; Owner: postgres
--

CREATE TYPE payment.usac_type AS ENUM (
    'debet',
    'credit card',
    'payment'
);


ALTER TYPE payment.usac_type OWNER TO postgres;

--
-- Name: get_transaction_payment(); Type: FUNCTION; Schema: payment; Owner: postgres
--

CREATE FUNCTION payment.get_transaction_payment() RETURNS TABLE(trpa_id integer, trpa_code_number character varying, trpa_order_number character varying, trpa_debet numeric, trpa_credit numeric, trpa_type payment.trpa_type, trpa_note character varying, trpa_modified_date timestamp with time zone, trpa_source_id integer, trpa_target_id integer, trpa_user_entity_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT tp.trpa_id, tp.trpa_code_number, tp.trpa_order_number, tp.trpa_debet, tp.trpa_credit,
         tp.trpa_type, tp.trpa_note, tp.trpa_modified_date,
         ua_source.usac_account_number, ua_target.usac_account_number,
         tp.trpa_user_entity_id
  FROM payment.transaction_payment tp
  JOIN payment.users_account ua_source ON CAST(tp.trpa_source_id AS VARCHAR) = ua_source.usac_account_number
  JOIN payment.users_account ua_target ON CAST(tp.trpa_target_id AS VARCHAR) = ua_target.usac_account_number;
END;
$$;


ALTER FUNCTION payment.get_transaction_payment() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bank; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.bank (
    bank_entity_id integer NOT NULL,
    bank_code character varying(10),
    bank_name character varying(55),
    bank_modified_date timestamp with time zone
);


ALTER TABLE payment.bank OWNER TO postgres;

--
-- Name: fintech; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.fintech (
    fint_entity_id integer NOT NULL,
    fint_code character varying(10),
    fint_name character varying(55),
    fint_modified_date timestamp with time zone
);


ALTER TABLE payment.fintech OWNER TO postgres;

--
-- Name: transaction_payment; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.transaction_payment (
    trpa_id integer NOT NULL,
    trpa_code_number character varying(55),
    trpa_order_number character varying(25),
    trpa_debet numeric,
    trpa_credit numeric,
    trpa_type payment.trpa_type,
    trpa_note character varying(255),
    trpa_modified_date timestamp with time zone,
    trpa_source_id integer,
    trpa_target_id integer,
    trpa_user_entity_id integer
);


ALTER TABLE payment.transaction_payment OWNER TO postgres;

--
-- Name: transaction_payment_trpa_id_seq; Type: SEQUENCE; Schema: payment; Owner: postgres
--

CREATE SEQUENCE payment.transaction_payment_trpa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment.transaction_payment_trpa_id_seq OWNER TO postgres;

--
-- Name: transaction_payment_trpa_id_seq; Type: SEQUENCE OWNED BY; Schema: payment; Owner: postgres
--

ALTER SEQUENCE payment.transaction_payment_trpa_id_seq OWNED BY payment.transaction_payment.trpa_id;


--
-- Name: users_account; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.users_account (
    usac_entity_id integer NOT NULL,
    usac_user_entity_id integer NOT NULL,
    usac_account_number character varying(25),
    usac_saldo numeric,
    usac_type payment.usac_type,
    usac_start_date timestamp with time zone,
    usac_end_date timestamp with time zone,
    usac_modified_date timestamp with time zone,
    usac_status payment.usac_status
);


ALTER TABLE payment.users_account OWNER TO postgres;

--
-- Name: users_account_usac_entity_id_seq; Type: SEQUENCE; Schema: payment; Owner: postgres
--

CREATE SEQUENCE payment.users_account_usac_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment.users_account_usac_entity_id_seq OWNER TO postgres;

--
-- Name: users_account_usac_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: payment; Owner: postgres
--

ALTER SEQUENCE payment.users_account_usac_entity_id_seq OWNED BY payment.users_account.usac_entity_id;


--
-- Name: business_entity; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.business_entity (
    entity_id integer NOT NULL
);


ALTER TABLE users.business_entity OWNER TO postgres;

--
-- Name: business_entity_entity_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.business_entity_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.business_entity_entity_id_seq OWNER TO postgres;

--
-- Name: business_entity_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.business_entity_entity_id_seq OWNED BY users.business_entity.entity_id;


--
-- Name: users; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users (
    user_entity_id integer NOT NULL
);


ALTER TABLE users.users OWNER TO postgres;

--
-- Name: users_user_entity_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.users_user_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.users_user_entity_id_seq OWNER TO postgres;

--
-- Name: users_user_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.users_user_entity_id_seq OWNED BY users.users.user_entity_id;


--
-- Name: transaction_payment trpa_id; Type: DEFAULT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.transaction_payment ALTER COLUMN trpa_id SET DEFAULT nextval('payment.transaction_payment_trpa_id_seq'::regclass);


--
-- Name: users_account usac_entity_id; Type: DEFAULT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account ALTER COLUMN usac_entity_id SET DEFAULT nextval('payment.users_account_usac_entity_id_seq'::regclass);


--
-- Name: business_entity entity_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.business_entity ALTER COLUMN entity_id SET DEFAULT nextval('users.business_entity_entity_id_seq'::regclass);


--
-- Name: users user_entity_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users ALTER COLUMN user_entity_id SET DEFAULT nextval('users.users_user_entity_id_seq'::regclass);


--
-- Data for Name: bank; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.bank (bank_entity_id, bank_code, bank_name, bank_modified_date) FROM stdin;
\.


--
-- Data for Name: fintech; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.fintech (fint_entity_id, fint_code, fint_name, fint_modified_date) FROM stdin;
\.


--
-- Data for Name: transaction_payment; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.transaction_payment (trpa_id, trpa_code_number, trpa_order_number, trpa_debet, trpa_credit, trpa_type, trpa_note, trpa_modified_date, trpa_source_id, trpa_target_id, trpa_user_entity_id) FROM stdin;
\.


--
-- Data for Name: users_account; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.users_account (usac_entity_id, usac_user_entity_id, usac_account_number, usac_saldo, usac_type, usac_start_date, usac_end_date, usac_modified_date, usac_status) FROM stdin;
\.


--
-- Data for Name: business_entity; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.business_entity (entity_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users (user_entity_id) FROM stdin;
\.


--
-- Name: transaction_payment_trpa_id_seq; Type: SEQUENCE SET; Schema: payment; Owner: postgres
--

SELECT pg_catalog.setval('payment.transaction_payment_trpa_id_seq', 1, false);


--
-- Name: users_account_usac_entity_id_seq; Type: SEQUENCE SET; Schema: payment; Owner: postgres
--

SELECT pg_catalog.setval('payment.users_account_usac_entity_id_seq', 1, false);


--
-- Name: business_entity_entity_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.business_entity_entity_id_seq', 1, false);


--
-- Name: users_user_entity_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.users_user_entity_id_seq', 1, false);


--
-- Name: bank bank_bank_code_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.bank
    ADD CONSTRAINT bank_bank_code_key UNIQUE (bank_code);


--
-- Name: bank bank_bank_name_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.bank
    ADD CONSTRAINT bank_bank_name_key UNIQUE (bank_name);


--
-- Name: bank bank_pkey; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.bank
    ADD CONSTRAINT bank_pkey PRIMARY KEY (bank_entity_id);


--
-- Name: fintech fintech_fint_code_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.fintech
    ADD CONSTRAINT fintech_fint_code_key UNIQUE (fint_code);


--
-- Name: fintech fintech_fint_name_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.fintech
    ADD CONSTRAINT fintech_fint_name_key UNIQUE (fint_name);


--
-- Name: fintech fintech_pkey; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.fintech
    ADD CONSTRAINT fintech_pkey PRIMARY KEY (fint_entity_id);


--
-- Name: transaction_payment transaction_payment_pkey; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.transaction_payment
    ADD CONSTRAINT transaction_payment_pkey PRIMARY KEY (trpa_id);


--
-- Name: transaction_payment transaction_payment_trpa_code_number_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.transaction_payment
    ADD CONSTRAINT transaction_payment_trpa_code_number_key UNIQUE (trpa_code_number);


--
-- Name: users_account users_account_pkey; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account
    ADD CONSTRAINT users_account_pkey PRIMARY KEY (usac_user_entity_id, usac_entity_id);


--
-- Name: users_account users_account_usac_account_number_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account
    ADD CONSTRAINT users_account_usac_account_number_key UNIQUE (usac_account_number);


--
-- Name: business_entity business_entity_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.business_entity
    ADD CONSTRAINT business_entity_pkey PRIMARY KEY (entity_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_entity_id);


--
-- Name: bank bank_bank_entity_id_fkey; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.bank
    ADD CONSTRAINT bank_bank_entity_id_fkey FOREIGN KEY (bank_entity_id) REFERENCES users.business_entity(entity_id);


--
-- Name: fintech fintech_fint_entity_id_fkey; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.fintech
    ADD CONSTRAINT fintech_fint_entity_id_fkey FOREIGN KEY (fint_entity_id) REFERENCES users.business_entity(entity_id);


--
-- Name: transaction_payment transaction_payment_trpa_user_entity_id_fkey; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.transaction_payment
    ADD CONSTRAINT transaction_payment_trpa_user_entity_id_fkey FOREIGN KEY (trpa_user_entity_id) REFERENCES users.users(user_entity_id);


--
-- Name: users_account users_account_usac_entity_id_fkey; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account
    ADD CONSTRAINT users_account_usac_entity_id_fkey FOREIGN KEY (usac_entity_id) REFERENCES payment.bank(bank_entity_id);


--
-- Name: users_account users_account_usac_entity_id_fkey1; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account
    ADD CONSTRAINT users_account_usac_entity_id_fkey1 FOREIGN KEY (usac_entity_id) REFERENCES payment.fintech(fint_entity_id);


--
-- Name: users_account users_account_usac_user_entity_id_fkey; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account
    ADD CONSTRAINT users_account_usac_user_entity_id_fkey FOREIGN KEY (usac_user_entity_id) REFERENCES users.users(user_entity_id);


--
-- PostgreSQL database dump complete
--

