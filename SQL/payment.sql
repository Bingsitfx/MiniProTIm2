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
-- Name: spaccountnumber(json, json, character varying); Type: PROCEDURE; Schema: payment; Owner: postgres
--

CREATE PROCEDURE payment.spaccountnumber(IN data1 json, IN data2 json, IN trpa_target_id character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_UserAccountNumber int;
    new_TransactionPaymentId int;
    source_account_number varchar(25);
    target_account_number varchar(25);
BEGIN
    WITH trpa_user_entity AS (
        INSERT INTO payment.transaction_payment(trpa_user_entity_id, trpa_source_id, trpa_target_id)
        SELECT x.trpa_user_entity_id, x.trpa_source_id, trpa_target_id
        FROM json_to_recordset(data1) x (trpa_user_entity_id int, trpa_source_id varchar)
        RETURNING trpa_id
    )
    SELECT trpa_id INTO new_TransactionPaymentId FROM trpa_user_entity;
    
    SELECT x.usac_account_number INTO source_account_number
    FROM json_to_recordset(data2) x (usac_user_entity_id int, usac_account_number varchar)
    WHERE x.usac_user_entity_id = new_TransactionPaymentId;
    
    INSERT INTO payment.users_account(usac_user_entity_id, usac_account_number)
    SELECT new_TransactionPaymentId, source_account_number;
    
    -- Transfer funds from source to target
    INSERT INTO payment.transaction_payment(trpa_source_id, trpa_target_id, trpa_debet, trpa_type, trpa_modified_date)
    SELECT tp.trpa_source_id, tp.trpa_target_id, tp.trpa_debet, 'transfer', now()
    FROM payment.transaction_payment tp
    WHERE tp.trpa_id = new_TransactionPaymentId;
    
    -- Update the source's credit by subtracting the transfer amount
    UPDATE payment.transaction_payment
    SET trpa_credit = trpa_credit - (SELECT trpa_debet FROM payment.transaction_payment WHERE trpa_id = new_TransactionPaymentId)
    WHERE trpa_id = new_TransactionPaymentId;
    
    -- Get the target's account number
    SELECT ua.usac_account_number INTO target_account_number
    FROM payment.transaction_payment tp
    JOIN payment.users_account ua ON ua.usac_user_entity_id = tp.trpa_target_id
    WHERE tp.trpa_id = new_TransactionPaymentId;
    
    -- Update the target's credit by adding the transfer amount
    UPDATE payment.transaction_payment
    SET trpa_credit = trpa_credit + (SELECT trpa_debet FROM payment.transaction_payment WHERE trpa_id = new_TransactionPaymentId)
    WHERE trpa_id = trpa_target_id;
    
    -- Optional: You can add additional validation or error handling here if required.
    
END;
$$;


ALTER PROCEDURE payment.spaccountnumber(IN data1 json, IN data2 json, IN trpa_target_id character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bank; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.bank (
    bank_entity_id integer NOT NULL,
    bank_code character varying(10),
    bank_name character varying(55),
    bank_modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE payment.bank OWNER TO postgres;

--
-- Name: bank_bank_entity_id_seq; Type: SEQUENCE; Schema: payment; Owner: postgres
--

CREATE SEQUENCE payment.bank_bank_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment.bank_bank_entity_id_seq OWNER TO postgres;

--
-- Name: bank_bank_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: payment; Owner: postgres
--

ALTER SEQUENCE payment.bank_bank_entity_id_seq OWNED BY payment.bank.bank_entity_id;


--
-- Name: fintech; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.fintech (
    fint_entity_id integer NOT NULL,
    fint_code character varying(10),
    fint_name character varying(55),
    fint_modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE payment.fintech OWNER TO postgres;

--
-- Name: fintech_fint_entity_id_seq; Type: SEQUENCE; Schema: payment; Owner: postgres
--

CREATE SEQUENCE payment.fintech_fint_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment.fintech_fint_entity_id_seq OWNER TO postgres;

--
-- Name: fintech_fint_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: payment; Owner: postgres
--

ALTER SEQUENCE payment.fintech_fint_entity_id_seq OWNED BY payment.fintech.fint_entity_id;


--
-- Name: transaction_payment; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.transaction_payment (
    trpa_id integer NOT NULL,
    trpa_code_number character varying(55),
    trpa_order_number character varying(25),
    trpa_debet numeric,
    trpa_credit numeric,
    trpa_type character varying(15),
    trpa_note character varying(255),
    trpa_modified_date timestamp with time zone DEFAULT now(),
    trpa_source_id character varying(25) NOT NULL,
    trpa_target_id character varying(25) NOT NULL,
    trpa_user_entity_id integer,
    CONSTRAINT transaction_payment_trpa_type_check CHECK (((trpa_type)::text = ANY ((ARRAY['topup'::character varying, 'transfer'::character varying, 'order'::character varying, 'refund'::character varying])::text[])))
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
    usac_bank_entity_id integer NOT NULL,
    usac_user_entity_id integer NOT NULL,
    usac_account_number character varying(25),
    usac_saldo numeric,
    usac_type character varying(15),
    usac_start_date date,
    usac_end_date date,
    usac_modified_date timestamp with time zone DEFAULT now(),
    usac_status character varying(15),
    CONSTRAINT users_account_usac_status_check CHECK (((usac_status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying, 'blokir'::character varying])::text[]))),
    CONSTRAINT users_account_usac_type_check CHECK (((usac_type)::text = ANY ((ARRAY['debet'::character varying, 'credit card'::character varying, 'payment'::character varying])::text[])))
);


ALTER TABLE payment.users_account OWNER TO postgres;

--
-- Name: users_account_usac_bank_entity_id_seq; Type: SEQUENCE; Schema: payment; Owner: postgres
--

CREATE SEQUENCE payment.users_account_usac_bank_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment.users_account_usac_bank_entity_id_seq OWNER TO postgres;

--
-- Name: users_account_usac_bank_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: payment; Owner: postgres
--

ALTER SEQUENCE payment.users_account_usac_bank_entity_id_seq OWNED BY payment.users_account.usac_bank_entity_id;


--
-- Name: users_account_usac_user_entity_id_seq; Type: SEQUENCE; Schema: payment; Owner: postgres
--

CREATE SEQUENCE payment.users_account_usac_user_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment.users_account_usac_user_entity_id_seq OWNER TO postgres;

--
-- Name: users_account_usac_user_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: payment; Owner: postgres
--

ALTER SEQUENCE payment.users_account_usac_user_entity_id_seq OWNED BY payment.users_account.usac_user_entity_id;


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
-- Name: bank bank_entity_id; Type: DEFAULT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.bank ALTER COLUMN bank_entity_id SET DEFAULT nextval('payment.bank_bank_entity_id_seq'::regclass);


--
-- Name: fintech fint_entity_id; Type: DEFAULT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.fintech ALTER COLUMN fint_entity_id SET DEFAULT nextval('payment.fintech_fint_entity_id_seq'::regclass);


--
-- Name: transaction_payment trpa_id; Type: DEFAULT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.transaction_payment ALTER COLUMN trpa_id SET DEFAULT nextval('payment.transaction_payment_trpa_id_seq'::regclass);


--
-- Name: users_account usac_bank_entity_id; Type: DEFAULT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account ALTER COLUMN usac_bank_entity_id SET DEFAULT nextval('payment.users_account_usac_bank_entity_id_seq'::regclass);


--
-- Name: users_account usac_user_entity_id; Type: DEFAULT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account ALTER COLUMN usac_user_entity_id SET DEFAULT nextval('payment.users_account_usac_user_entity_id_seq'::regclass);


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
1	001	BCA	2023-06-07 09:00:25.381159+07
2	002	BNI	2023-06-07 09:00:34.913113+07
\.


--
-- Data for Name: fintech; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.fintech (fint_entity_id, fint_code, fint_name, fint_modified_date) FROM stdin;
1	Goto	Gojek Tokopedia	2023-06-07 09:01:07.05947+07
2	Paylater	Shopee	2023-06-07 09:12:45.282575+07
\.


--
-- Data for Name: transaction_payment; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.transaction_payment (trpa_id, trpa_code_number, trpa_order_number, trpa_debet, trpa_credit, trpa_type, trpa_note, trpa_modified_date, trpa_source_id, trpa_target_id, trpa_user_entity_id) FROM stdin;
\.


--
-- Data for Name: users_account; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.users_account (usac_bank_entity_id, usac_user_entity_id, usac_account_number, usac_saldo, usac_type, usac_start_date, usac_end_date, usac_modified_date, usac_status) FROM stdin;
\.


--
-- Data for Name: business_entity; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.business_entity (entity_id) FROM stdin;
1
2
3
4
5
6
7
8
9
10
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users (user_entity_id) FROM stdin;
\.


--
-- Name: bank_bank_entity_id_seq; Type: SEQUENCE SET; Schema: payment; Owner: postgres
--

SELECT pg_catalog.setval('payment.bank_bank_entity_id_seq', 2, true);


--
-- Name: fintech_fint_entity_id_seq; Type: SEQUENCE SET; Schema: payment; Owner: postgres
--

SELECT pg_catalog.setval('payment.fintech_fint_entity_id_seq', 2, true);


--
-- Name: transaction_payment_trpa_id_seq; Type: SEQUENCE SET; Schema: payment; Owner: postgres
--

SELECT pg_catalog.setval('payment.transaction_payment_trpa_id_seq', 1, false);


--
-- Name: users_account_usac_bank_entity_id_seq; Type: SEQUENCE SET; Schema: payment; Owner: postgres
--

SELECT pg_catalog.setval('payment.users_account_usac_bank_entity_id_seq', 1, false);


--
-- Name: users_account_usac_user_entity_id_seq; Type: SEQUENCE SET; Schema: payment; Owner: postgres
--

SELECT pg_catalog.setval('payment.users_account_usac_user_entity_id_seq', 1, false);


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
    ADD CONSTRAINT users_account_pkey PRIMARY KEY (usac_user_entity_id, usac_bank_entity_id);


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
-- Name: users_account users_account_usac_bank_entity_id_fkey; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account
    ADD CONSTRAINT users_account_usac_bank_entity_id_fkey FOREIGN KEY (usac_bank_entity_id) REFERENCES payment.bank(bank_entity_id);


--
-- Name: users_account users_account_usac_bank_entity_id_fkey1; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account
    ADD CONSTRAINT users_account_usac_bank_entity_id_fkey1 FOREIGN KEY (usac_bank_entity_id) REFERENCES payment.fintech(fint_entity_id);


--
-- Name: users_account users_account_usac_user_entity_id_fkey; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.users_account
    ADD CONSTRAINT users_account_usac_user_entity_id_fkey FOREIGN KEY (usac_user_entity_id) REFERENCES users.users(user_entity_id);


--
-- PostgreSQL database dump complete
--

