-- Table: job_hire.job_post_desc

-- DROP TABLE IF EXISTS job_hire.job_post_desc;

CREATE TABLE IF NOT EXISTS job_hire.job_post_desc
(
    jopo_entity_id integer NOT NULL,
    jopo_description json,
    jopo_responsibility json,
    jopo_target json,
    jopo_benefit json,
    CONSTRAINT job_post_desc_pkey PRIMARY KEY (jopo_entity_id),
    CONSTRAINT job_post_desc_jopo_entity_id_fkey FOREIGN KEY (jopo_entity_id)
        REFERENCES job_hire.job_post (jopo_entity_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS job_hire.job_post_desc
    OWNER to postgres;