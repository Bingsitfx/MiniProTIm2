-- Table: job_hire.client

-- DROP TABLE IF EXISTS job_hire.client;

CREATE TABLE IF NOT EXISTS job_hire.client
(
    clit_id integer NOT NULL DEFAULT 'nextval('job_hire.client_clit_id_seq'::regclass)',
    clit_name character varying(256) COLLATE pg_catalog."default",
    clit_about character varying(512) COLLATE pg_catalog."default",
    clit_modified_date timestamp with time zone DEFAULT 'CURRENT_TIMESTAMP',
    clit_addr_id integer,
    clit_emra_id integer,
    clit_indu_code character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT client_pkey PRIMARY KEY (clit_id),
    CONSTRAINT client_clit_name_key UNIQUE (clit_name),
    CONSTRAINT client_clit_addr_id_fkey FOREIGN KEY (clit_addr_id)
        REFERENCES master.address (addr_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT client_clit_emra_id_fkey FOREIGN KEY (clit_emra_id)
        REFERENCES job_hire.employee_range (emra_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT client_clit_indu_code_fkey FOREIGN KEY (clit_indu_code)
        REFERENCES master.industry (indu_code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS job_hire.client
    OWNER to postgres;