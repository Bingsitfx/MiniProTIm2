-- View: job_hire.client_view

-- DROP VIEW job_hire.client_view;

CREATE OR REPLACE VIEW job_hire.client_view
 AS
 SELECT client.clit_id,
    client.clit_name,
    client.clit_about,
    client.clit_modified_date,
    client.clit_addr_id,
    client.clit_emra_id,
    client.clit_indu_code,
    employee_range.emra_id,
    employee_range.emra_range_min,
    employee_range.emra_range_max,
    employee_range.emra_modified_date,
    industry.indu_code,
    industry.indu_name,
    address.addr_id,
    address.addr_line1,
    address.addr_line2,
    address.addr_postal_code,
    address.addr_spatial_location,
    address.addr_modifed_date,
    address.addr_city_id,
    city.city_id,
    city.city_name,
    city.city_modified_date,
    city.city_prov_id,
    province.prov_id,
    province.prov_code,
    province.prov_name,
    province.prov_modified_date,
    province.prov_country_code,
    country.country_code,
    country.country_name,
    country.country_modified_date
   FROM job_hire.client
     JOIN job_hire.employee_range ON client.clit_emra_id = employee_range.emra_id
     JOIN master.industry ON client.clit_indu_code::text = industry.indu_code::text
     JOIN master.address ON client.clit_addr_id = address.addr_id
     JOIN master.city ON address.addr_city_id = city.city_id
     JOIN master.province ON city.city_prov_id = province.prov_id
     JOIN master.country ON country.country_code::text = province.prov_country_code::text;

ALTER TABLE job_hire.client_view
    OWNER TO postgres;

