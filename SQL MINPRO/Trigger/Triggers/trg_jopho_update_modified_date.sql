-- Trigger: trg_jopho_update_modified_date

-- DROP TRIGGER IF EXISTS trg_jopho_update_modified_date ON job_hire.job_photo;

CREATE TRIGGER trg_jopho_update_modified_date
    BEFORE UPDATE 
    ON job_hire.job_photo
    FOR EACH ROW
    EXECUTE FUNCTION job_hire.update_jopho_modified_date();