-- View: job_hire.job_list_view

-- DROP VIEW job_hire.job_list_view;

CREATE OR REPLACE VIEW job_hire.job_list_view
 AS
 SELECT jopo.jopo_entity_id,
    jopo.jopo_number,
    jopo.jopo_title,
    jopo.jopo_start_date,
    jopo.jopo_end_date,
    jopo.jopo_min_salary,
    jopo.jopo_max_salary,
    jopo.jopo_min_experience,
    jopo.jopo_max_experience,
    jopo.jopo_primary_skill,
    jopo.jopo_secondary_skill,
    jopo.jopo_publish_date,
    jopo.jopo_clit_id,
    jopo.jopo_joro_id,
    joro.joro_name,
    jopo.jopo_joty_id,
    jopo.jopo_joca_id,
    jopo.jopo_addr_id,
    jopo.jopo_work_code,
    woty.woty_name,
    jopo.jopo_edu_code,
    jopo.jopo_status,
    jopo.jopo_id,
    jopo.jopo_open,
    jopo.jopo_emp_entity_id,
    jode.jopo_description,
    jode.jopo_target,
    jode.jopo_benefit,
    jopho.jopho_id,
    jopho.jopho_filename,
    jopho.jopho_filesize,
    jopho.jopho_filetype,
    jopo.jopo_modified_date,
    clit.clit_id,
    clit.clit_name,
    clit.clit_about,
    clit.clit_addr_id,
    clit.clit_emra_id,
    emra.emra_range_min,
    emra.emra_range_max,
    clit.clit_indu_code,
    indu.indu_name,
    addr.addr_id,
    addr.addr_line1,
    addr.addr_line2,
    addr.addr_postal_code,
    addr.addr_spatial_location,
    addr.addr_city_id,
    city.city_id,
    city.city_name,
    city.city_prov_id,
    prov.prov_name
   FROM job_hire.job_post jopo
     JOIN job_hire.job_post_desc jode ON jopo.jopo_entity_id = jode.jopo_entity_id
     JOIN job_hire.job_photo jopho ON jopo.jopo_entity_id = jopho.jopho_entity_id
     JOIN job_hire.client clit ON jopo.jopo_clit_id = clit.clit_id
     JOIN master.address addr ON clit.clit_addr_id = addr.addr_id
     JOIN master.industry indu ON clit.clit_indu_code::text = indu.indu_code::text
     JOIN master.city city ON addr.addr_city_id = city.city_id
     JOIN master.province prov ON city.city_prov_id = prov.prov_id
     JOIN master.job_role joro ON jopo.jopo_joro_id = joro.joro_id
     JOIN master.working_type woty ON jopo.jopo_work_code::text = woty.woty_code::text
     JOIN job_hire.employee_range emra ON clit.clit_emra_id = emra.emra_id;

ALTER TABLE job_hire.job_list_view
    OWNER TO postgres;

