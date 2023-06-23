-- SEQUENCE: job_hire.client_clit_id_seq

-- DROP SEQUENCE IF EXISTS job_hire.client_clit_id_seq;

CREATE SEQUENCE IF NOT EXISTS job_hire.client_clit_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY client.clit_id;

ALTER SEQUENCE job_hire.client_clit_id_seq
    OWNER TO postgres;