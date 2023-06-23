-- Table: job_hire.talent_apply_progress

-- DROP TABLE IF EXISTS job_hire.talent_apply_progress;

CREATE TABLE IF NOT EXISTS job_hire.talent_apply_progress
(
    tapr_id integer NOT NULL DEFAULT 'nextval('job_hire.talent_apply_progress_tapr_id_seq'::regclass)',
    tapr_taap_user_entity_id integer NOT NULL,
    tapr_taap_entity_id integer NOT NULL,
    tapr_modified_date timestamp with time zone DEFAULT 'CURRENT_TIMESTAMP',
    tapr_status character varying(15) COLLATE pg_catalog."default",
    tapr_comment character varying(256) COLLATE pg_catalog."default",
    tapr_progress_name character varying(55) COLLATE pg_catalog."default",
    CONSTRAINT talent_apply_progress_pkey PRIMARY KEY (tapr_id, tapr_taap_user_entity_id, tapr_taap_entity_id),
    CONSTRAINT talent_apply_progress_tapr_progress_name_fkey FOREIGN KEY (tapr_progress_name)
        REFERENCES master.route_actions (roac_name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT talent_apply_progress_tapr_status_fkey FOREIGN KEY (tapr_status)
        REFERENCES master.status (status) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT talent_apply_progress_tapr_taap_user_entity_id_tapr_taap_e_fkey FOREIGN KEY (tapr_taap_entity_id, tapr_taap_user_entity_id)
        REFERENCES job_hire.talent_apply (taap_entity_id, taap_user_entity_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT talent_apply_progress_tapr_status_check CHECK (tapr_status::text = ANY (ARRAY['Open'::character varying::text, 'Waiting'::character varying::text, 'Done'::character varying::text, 'Cancelled'::character varying::text, 'Closed'::character varying::text]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS job_hire.talent_apply_progress
    OWNER to postgres;