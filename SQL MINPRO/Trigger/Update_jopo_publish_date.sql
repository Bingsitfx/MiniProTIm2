-- FUNCTION: job_hire.update_jopo_publish_date()

-- DROP FUNCTION IF EXISTS job_hire.update_jopo_publish_date();

CREATE OR REPLACE FUNCTION job_hire.update_jopo_publish_date()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  IF NEW.jopo_status = 'publish' THEN
    NEW.jopo_publish_date = CURRENT_DATE;
  ELSE
  	NEW.jopo_publish_date = OLD.jopo_publish_date;
  END IF;

  RETURN NEW;
END;
$BODY$;

ALTER FUNCTION job_hire.update_jopo_publish_date()
    OWNER TO postgres;
