-- Table: job_hire.employee_range

-- DROP TABLE IF EXISTS job_hire.employee_range;

CREATE TABLE IF NOT EXISTS job_hire.employee_range
(
    emra_id integer NOT NULL DEFAULT 'nextval('job_hire.employee_range_emra_id_seq'::regclass)',
    emra_range_min integer,
    emra_range_max integer,
    emra_modified_date timestamp with time zone DEFAULT 'CURRENT_TIMESTAMP',
    CONSTRAINT employee_range_pkey PRIMARY KEY (emra_id),
    CONSTRAINT employee_range_emra_range_max_key UNIQUE (emra_range_max),
    CONSTRAINT employee_range_emra_range_min_key UNIQUE (emra_range_min)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS job_hire.employee_range
    OWNER to postgres;