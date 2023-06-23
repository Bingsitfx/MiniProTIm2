-- FUNCTION: job_hire.update_jopho_modified_date()

-- DROP FUNCTION IF EXISTS job_hire.update_jopho_modified_date();

CREATE OR REPLACE FUNCTION job_hire.update_jopho_modified_date()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    NEW.jopho_modified_date := NOW();
    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION job_hire.update_jopho_modified_date()
    OWNER TO postgres;
