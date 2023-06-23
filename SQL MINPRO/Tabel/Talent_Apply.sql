-- Table: job_hire.talent_apply

-- DROP TABLE IF EXISTS job_hire.talent_apply;

CREATE TABLE IF NOT EXISTS job_hire.talent_apply
(
    taap_user_entity_id integer NOT NULL,
    taap_entity_id integer NOT NULL,
    taap_intro character varying(512) COLLATE pg_catalog."default",
    taap_scoring integer,
    taap_modified_date timestamp with time zone DEFAULT 'CURRENT_TIMESTAMP',
    taap_status character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT talent_apply_pkey PRIMARY KEY (taap_user_entity_id, taap_entity_id),
    CONSTRAINT talent_apply_taap_entity_id_fkey FOREIGN KEY (taap_entity_id)
        REFERENCES job_hire.job_post (jopo_entity_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT talent_apply_taap_status_fkey FOREIGN KEY (taap_status)
        REFERENCES master.status (status) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT talent_apply_taap_user_entity_id_fkey FOREIGN KEY (taap_user_entity_id)
        REFERENCES users.users (user_entity_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT talent_apply_taap_status_check CHECK (taap_status::text = ANY (ARRAY['interview'::character varying::text, 'failed'::character varying::text, 'succeed'::character varying::text]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS job_hire.talent_apply
    OWNER to postgres;