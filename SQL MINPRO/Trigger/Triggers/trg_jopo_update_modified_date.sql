-- Trigger: trg_jopo_update_modified_date

-- DROP TRIGGER IF EXISTS trg_jopo_update_modified_date ON job_hire.job_post;

CREATE TRIGGER trg_jopo_update_modified_date
    BEFORE UPDATE 
    ON job_hire.job_post
    FOR EACH ROW
    EXECUTE FUNCTION job_hire.update_jopo_modified_date();