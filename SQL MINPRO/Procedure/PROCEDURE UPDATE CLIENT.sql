-- PROCEDURE: job_hire.updateclient(integer, json, json)

-- DROP PROCEDURE IF EXISTS job_hire.updateclient(integer, json, json);

CREATE OR REPLACE PROCEDURE job_hire.updateclient(
	IN id integer,
	IN data json,
	IN data1 json)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  address_id INT;
BEGIN
  SELECT clit_addr_id INTO address_id FROM job_hire.client WHERE clit_id = id;

  UPDATE master.address
  SET
  	addr_line1 = x.addr_line1,
    addr_line2 = x.addr_line2,
    addr_postal_code = x.addr_postal_code,
    addr_spatial_location = x.addr_spatial_location,
    addr_city_id = x.addr_city_id
  FROM json_to_recordset(data) AS x(
	  addr_line1 varchar(255),
      addr_line2 varchar(255),
      addr_postal_code varchar(10),
      addr_spatial_location json,
      addr_city_id INT
  )
  WHERE addr_id = address_id;
  
  UPDATE job_hire.client
  SET
    clit_name = x.clit_name,
    clit_about = x.clit_about,
    clit_addr_id = address_id,
    clit_emra_id = x.clit_emra_id,
    clit_indu_code = x.clit_indu_code
  FROM json_to_recordset(data1) AS x(
    clit_name varchar(256),
    clit_about varchar(512),
    clit_emra_id int,
    clit_indu_code varchar(15)
  )
  WHERE clit_addr_id = address_id;
END;
$BODY$;
ALTER PROCEDURE job_hire.updateclient(integer, json, json)
    OWNER TO postgres;
