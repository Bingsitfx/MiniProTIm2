-- Trigger: trigger_update_jopo_publish_date

-- DROP TRIGGER IF EXISTS trigger_update_jopo_publish_date ON job_hire.job_post;

CREATE TRIGGER trigger_update_jopo_publish_date
    BEFORE UPDATE OF jopo_status
    ON job_hire.job_post
    FOR EACH ROW
    EXECUTE FUNCTION job_hire.update_jopo_publish_date();