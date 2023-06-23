-- Table: job_hire.job_post

-- DROP TABLE IF EXISTS job_hire.job_post;

CREATE TABLE IF NOT EXISTS job_hire.job_post
(
    jopo_entity_id integer NOT NULL,
    jopo_number character varying(25) COLLATE pg_catalog."default",
    jopo_title character varying(256) COLLATE pg_catalog."default",
    jopo_start_date date,
    jopo_end_date date,
    jopo_min_salary numeric,
    jopo_max_salary numeric,
    jopo_min_experience integer,
    jopo_max_experience integer,
    jopo_primary_skill character varying(256) COLLATE pg_catalog."default",
    jopo_secondary_skill character varying(256) COLLATE pg_catalog."default",
    jopo_publish_date date,
    jopo_modified_date timestamp with time zone DEFAULT 'CURRENT_TIMESTAMP',
    jopo_emp_entity_id integer,
    jopo_clit_id integer,
    jopo_joro_id integer,
    jopo_joty_id integer,
    jopo_joca_id integer,
    jopo_addr_id integer,
    jopo_work_code character varying(15) COLLATE pg_catalog."default",
    jopo_edu_code character varying(15) COLLATE pg_catalog."default",
    jopo_status character varying(15) COLLATE pg_catalog."default" NOT NULL,
    jopo_id integer NOT NULL DEFAULT 'nextval('job_hire.job_post_jopo_id_seq'::regclass)',
    jopo_open character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 1,
    CONSTRAINT job_post_pkey PRIMARY KEY (jopo_entity_id),
    CONSTRAINT job_post_jopo_number_key UNIQUE (jopo_number),
    CONSTRAINT job_post_jopo_addr_id_fkey FOREIGN KEY (jopo_addr_id)
        REFERENCES master.address (addr_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_post_jopo_clit_id_fkey FOREIGN KEY (jopo_clit_id)
        REFERENCES job_hire.client (clit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_post_jopo_edu_code_fkey FOREIGN KEY (jopo_edu_code)
        REFERENCES master.education (edu_code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_post_jopo_emp_entity_id_fkey FOREIGN KEY (jopo_emp_entity_id)
        REFERENCES hr.employee (emp_entity_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_post_jopo_entity_id_fkey FOREIGN KEY (jopo_entity_id)
        REFERENCES users.business_entity (entity_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_post_jopo_joca_id_fkey FOREIGN KEY (jopo_joca_id)
        REFERENCES job_hire.job_category (joca_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_post_jopo_joro_id_fkey FOREIGN KEY (jopo_joro_id)
        REFERENCES master.job_role (joro_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_post_jopo_joty_id_fkey FOREIGN KEY (jopo_joty_id)
        REFERENCES master.job_type (joty_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_post_jopo_status_fkey FOREIGN KEY (jopo_status)
        REFERENCES master.status (status) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_post_jopo_work_code_fkey FOREIGN KEY (jopo_work_code)
        REFERENCES master.working_type (woty_code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_post_jopo_open_check CHECK (jopo_open = ANY (ARRAY['0'::bpchar, '1'::bpchar])),
    CONSTRAINT job_post_jopo_status_check CHECK (jopo_status::text = ANY (ARRAY['publish'::character varying::text, 'draft'::character varying::text, 'cancelled'::character varying::text, 'remove'::character varying::text]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS job_hire.job_post
    OWNER to postgres;

-- Trigger: trg_jopo_update_modified_date

-- DROP TRIGGER IF EXISTS trg_jopo_update_modified_date ON job_hire.job_post;

CREATE TRIGGER trg_jopo_update_modified_date
    BEFORE UPDATE 
    ON job_hire.job_post
    FOR EACH ROW
    EXECUTE FUNCTION job_hire.update_jopo_modified_date();

-- Trigger: trigger_update_jopo_publish_date

-- DROP TRIGGER IF EXISTS trigger_update_jopo_publish_date ON job_hire.job_post;

CREATE TRIGGER trigger_update_jopo_publish_date
    BEFORE UPDATE OF jopo_status
    ON job_hire.job_post
    FOR EACH ROW
    EXECUTE FUNCTION job_hire.update_jopo_publish_date();