-- Table: job_hire.job_category

-- DROP TABLE IF EXISTS job_hire.job_category;

CREATE TABLE IF NOT EXISTS job_hire.job_category
(
    joca_id integer NOT NULL DEFAULT 'nextval('job_hire.job_category_joca_id_seq'::regclass)',
    joca_name character varying(255) COLLATE pg_catalog."default",
    joca_modified_date timestamp with time zone DEFAULT 'CURRENT_TIMESTAMP',
    CONSTRAINT job_category_pkey PRIMARY KEY (joca_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS job_hire.job_category
    OWNER to postgres;