-- Table: job_hire.job_photo

-- DROP TABLE IF EXISTS job_hire.job_photo;

CREATE TABLE IF NOT EXISTS job_hire.job_photo
(
    jopho_id integer NOT NULL DEFAULT 'nextval('job_hire.job_photo_jopho_id_seq'::regclass)',
    jopho_filename character varying(55) COLLATE pg_catalog."default",
    jopho_filesize integer,
    jopho_filetype character varying(15) COLLATE pg_catalog."default",
    jopho_modified_date timestamp with time zone DEFAULT 'CURRENT_TIMESTAMP',
    jopho_entity_id integer,
    CONSTRAINT job_photo_pkey PRIMARY KEY (jopho_id),
    CONSTRAINT job_photo_jopho_entity_id_fkey FOREIGN KEY (jopho_entity_id)
        REFERENCES job_hire.job_post (jopo_entity_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_photo_jopho_filetype_check CHECK (jopho_filetype::text = ANY (ARRAY['png'::character varying::text, 'jpg'::character varying::text, 'jpeg'::character varying::text]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS job_hire.job_photo
    OWNER to postgres;

-- Trigger: trg_jopho_update_modified_date

-- DROP TRIGGER IF EXISTS trg_jopho_update_modified_date ON job_hire.job_photo;

CREATE TRIGGER trg_jopho_update_modified_date
    BEFORE UPDATE 
    ON job_hire.job_photo
    FOR EACH ROW
    EXECUTE FUNCTION job_hire.update_jopho_modified_date();