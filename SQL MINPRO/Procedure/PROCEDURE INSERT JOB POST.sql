-- PROCEDURE: job_hire.createpostingjob(json, json, json)

-- DROP PROCEDURE IF EXISTS job_hire.createpostingjob(json, json, json);

CREATE OR REPLACE PROCEDURE job_hire.createpostingjob(
	IN data json,
	IN data1 json,
	IN data2 json)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	bus_entity_id INT;
	
BEGIN
	WITH result AS (
		INSERT INTO users.business_entity (entity_id) VALUES (DEFAULT)
		RETURNING entity_id
	)
	SELECT entity_id INTO bus_entity_id FROM result;

	INSERT INTO job_hire.job_post (
		jopo_entity_id,
		jopo_number,
		jopo_title,
		jopo_start_date,
		jopo_end_date,
		jopo_min_salary,
		jopo_max_salary,
		jopo_min_experience,
		jopo_max_experience,
		jopo_primary_skill,
		jopo_secondary_skill,
		jopo_publish_date,
		jopo_emp_entity_id,
		jopo_clit_id,
		jopo_joro_id,
		jopo_joty_id,
		--jopo_joca_id,
		jopo_addr_id,
		jopo_work_code,
		jopo_edu_code,
		jopo_status,
		jopo_open
	)
	SELECT
		bus_entity_id,
		x.jopo_number,
		x.jopo_title,
		x.jopo_start_date,
		x.jopo_end_date,
		x.jopo_min_salary,
		x.jopo_max_salary,
		x.jopo_min_experience,
		x.jopo_max_experience,
		x.jopo_primary_skill,
		x.jopo_secondary_skill,
		CASE WHEN x.jopo_status = 'publish' THEN CURRENT_DATE ELSE NULL END,
		x.jopo_emp_entity_id,
		x.jopo_clit_id,
		x.jopo_joro_id,
		x.jopo_joty_id,
		--x.jopo_joca_id,
		(SELECT clit_addr_id FROM job_hire.client WHERE clit_id = x.jopo_clit_id),
		x.jopo_work_code,
		x.jopo_edu_code,
		x.jopo_status,
		x.jopo_open
	FROM json_to_recordset(data) AS x(
		jopo_entity_id INT,
		jopo_number VARCHAR(25),
		jopo_title VARCHAR(256),
		jopo_start_date DATE,
		jopo_end_date DATE,
		jopo_min_salary INT,
		jopo_max_salary INT,
		jopo_min_experience INT,
		jopo_max_experience INT,
		jopo_primary_skill VARCHAR(256),
		jopo_secondary_skill VARCHAR(256),
		jopo_publish_date DATE,
		jopo_emp_entity_id INT,
		jopo_clit_id INT,
		jopo_joro_id INT,
		jopo_joty_id INT,
		--jopo_joca_id INT,
		jopo_addr_id INT,
		jopo_work_code VARCHAR(15),
		jopo_edu_code VARCHAR(15),
		jopo_status VARCHAR(15),
		jopo_open CHAR(1)
	);

	INSERT INTO job_hire.job_post_desc (
		jopo_entity_id,
		jopo_description,
-- 		jopo_responsibility,
		jopo_target,
		jopo_benefit
	)
	SELECT
		bus_entity_id,
		x.jopo_description,
-- 		x.jopo_responsibility,
		x.jopo_target,
		x.jopo_benefit
	FROM json_to_recordset(data1) AS x(
		jopo_entity_id INT,
		jopo_description JSON,
-- 		jopo_responsibility JSON,
		jopo_target JSON,
		jopo_benefit JSON
	);

	INSERT INTO job_hire.job_photo (
		jopho_entity_id,
		jopho_filename,
		jopho_filesize,
		jopho_filetype
	)
	SELECT
		bus_entity_id,
		x.jopho_filename,
		x.jopho_filesize,
		x.jopho_filetype
	FROM json_to_recordset(data2) AS x(
		jopho_entity_id INT,
		jopho_filename VARCHAR(55),
		jopho_filesize INT,
		jopho_filetype VARCHAR(15)
	);
END;
$BODY$;
ALTER PROCEDURE job_hire.createpostingjob(json, json, json)
    OWNER TO postgres;
