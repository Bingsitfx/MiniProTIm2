-- PROCEDURE: job_hire.createclient(json, json)

-- DROP PROCEDURE IF EXISTS job_hire.createclient(json, json);

CREATE OR REPLACE PROCEDURE job_hire.createclient(
	IN data json,
	IN data1 json)
LANGUAGE 'plpgsql'
AS $BODY$
declare
 address_id INT;
begin
 WITH result AS (
	INSERT INTO master.address (
		addr_line1,
		addr_line2,
		addr_postal_code,
		addr_spatial_location,
		addr_city_id
	)
	 SELECT
	 	x.addr_line1,
		x.addr_line2,
		x.addr_postal_code,
		x.addr_spatial_location,
		x.addr_city_id
	 FROM json_to_recordset(data) AS x(
	 	addr_line1 varchar(255),
		addr_line2 varchar(255),
		addr_postal_code varchar(10),
		addr_spatial_location json,
		addr_city_id INT
	 )
	RETURNING addr_id
 )
 SELECT addr_id INTO address_id FROM result;
 
 INSERT INTO job_hire.client (
  	 clit_name,
	 clit_about,
	 clit_addr_id,
	 clit_emra_id,
	 clit_indu_code
 )
 SELECT 
 	 x.clit_name,
	 x.clit_about,
	 address_id,
	 x.clit_emra_id,
	 x.clit_indu_code
 FROM json_to_recordset(data1) AS x(
	 clit_name varchar(256),
	 clit_about varchar(512),
	 clit_addr_id int,
	 clit_emra_id int,
	 clit_indu_code varchar(15)
 );
end;
$BODY$;
ALTER PROCEDURE job_hire.createclient(json, json)
    OWNER TO postgres;
