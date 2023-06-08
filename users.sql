--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: master; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA master;


ALTER SCHEMA master OWNER TO postgres;

--
-- Name: test; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA test;


ALTER SCHEMA test OWNER TO postgres;

--
-- Name: users; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA users;


ALTER SCHEMA users OWNER TO postgres;

--
-- Name: roac_display; Type: TYPE; Schema: master; Owner: postgres
--

CREATE TYPE master.roac_display AS ENUM (
    '0',
    '1'
);


ALTER TYPE master.roac_display OWNER TO postgres;

--
-- Name: insertdataintorolesandusers(character varying, integer, integer); Type: PROCEDURE; Schema: test; Owner: postgres
--

CREATE PROCEDURE test.insertdataintorolesandusers(IN p_role_name character varying, IN p_user_entity_id integer, IN p_user_current_role integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO test.roles (role_name)
  VALUES (p_role_name);
  
  INSERT INTO test.users (user_entity_id, user_current_role)
  VALUES (p_user_entity_id, p_user_current_role);
END;
$$;


ALTER PROCEDURE test.insertdataintorolesandusers(IN p_role_name character varying, IN p_user_entity_id integer, IN p_user_current_role integer) OWNER TO postgres;

--
-- Name: insertuserwithrole(); Type: PROCEDURE; Schema: test; Owner: postgres
--

CREATE PROCEDURE test.insertuserwithrole()
    LANGUAGE plpgsql
    AS $$
declare
	entityId int;
BEGIN
	insert into test.business_entity default values
	returning entity_id into entityId;
	
	insert into test.users (user_entity_id)
	values (entityId);
	
    COMMIT;
END;
$$;


ALTER PROCEDURE test.insertuserwithrole() OWNER TO postgres;

--
-- Name: insertuserwithrole(integer); Type: PROCEDURE; Schema: test; Owner: postgres
--

CREATE PROCEDURE test.insertuserwithrole(IN role integer)
    LANGUAGE plpgsql
    AS $$
declare
	entityId int;
	userRole int;
BEGIN
	insert into test.business_entity default values
	returning entity_id into entityId;
	
	insert into test.users (user_entity_id)
	values (entityId);
	
	insert into test.users_roles (usro_entity_id,usro_role_id)
	values (entityId,role)
	returning usro_role_id into userRole;
	
	update test.users
	set user_current_role = userRole
	where user_entity_id = entityId;
	
END;
$$;


ALTER PROCEDURE test.insertuserwithrole(IN role integer) OWNER TO postgres;

--
-- Name: insertuserwithrole(integer, integer, integer, integer); Type: PROCEDURE; Schema: test; Owner: postgres
--

CREATE PROCEDURE test.insertuserwithrole(IN p_user_entity_id integer, IN p_user_current_role integer, IN p_usro_entity_id integer, IN p_usro_role_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO test.users (user_entity_id, user_current_role)
    VALUES (p_user_entity_id, p_user_current_role);

    INSERT INTO test.users_roles (usro_entity_id, usro_role_id)
    VALUES (p_usro_entity_id, p_usro_role_id);
    
    COMMIT;
END;
$$;


ALTER PROCEDURE test.insertuserwithrole(IN p_user_entity_id integer, IN p_user_current_role integer, IN p_usro_entity_id integer, IN p_usro_role_id integer) OWNER TO postgres;

--
-- Name: addemail(integer, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.addemail(IN entityid integer, IN newemail character varying)
    LANGUAGE plpgsql
    AS $$
begin
	insert into users.users_email (pmail_entity_id,pmail_address)
	values (entityId,newEmail);
end
$$;


ALTER PROCEDURE users.addemail(IN entityid integer, IN newemail character varying) OWNER TO postgres;

--
-- Name: addphone(integer, character varying, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.addphone(IN entityid integer, IN newphone character varying, IN pontycode character varying)
    LANGUAGE plpgsql
    AS $$
begin
	insert into users.users_phones (uspo_entity_id,uspo_number,uspo_ponty_code)
	values (entityId,newPhone,pontyCode);
end
$$;


ALTER PROCEDURE users.addphone(IN entityid integer, IN newphone character varying, IN pontycode character varying) OWNER TO postgres;

--
-- Name: changepassword(integer, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.changepassword(IN entityid integer, IN newpassword character varying)
    LANGUAGE plpgsql
    AS $$
begin
	update users.users
	set user_password =  newPassword
	where user_entity_id = entityId;
end;
$$;


ALTER PROCEDURE users.changepassword(IN entityid integer, IN newpassword character varying) OWNER TO postgres;

--
-- Name: deleteemail(integer); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.deleteemail(IN emailid integer)
    LANGUAGE plpgsql
    AS $$
begin
	delete from users.users_email where pmail_id = emailId;
end
$$;


ALTER PROCEDURE users.deleteemail(IN emailid integer) OWNER TO postgres;

--
-- Name: deletephone(integer, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.deletephone(IN entityid integer, IN pontycode character varying)
    LANGUAGE plpgsql
    AS $$
begin
	delete from users.users_phones
	where uspo_entity_id =  entityId and uspo_ponty_code = pontyCode;
end
$$;


ALTER PROCEDURE users.deletephone(IN entityid integer, IN pontycode character varying) OWNER TO postgres;

--
-- Name: editemail(integer, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.editemail(IN emailid integer, IN newemail character varying)
    LANGUAGE plpgsql
    AS $$
begin
	update users.users_email
	set pmail_address =  newEmail
	where pmail_id = emailId;
end
$$;


ALTER PROCEDURE users.editemail(IN emailid integer, IN newemail character varying) OWNER TO postgres;

--
-- Name: editphone(integer, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.editphone(IN entityid integer, IN newphone character varying)
    LANGUAGE plpgsql
    AS $$
begin
	update users.users_phones
	set uspo_number = newPhone
	where uspo_entity_id =  entityId;
end
$$;


ALTER PROCEDURE users.editphone(IN entityid integer, IN newphone character varying) OWNER TO postgres;

--
-- Name: editphone(integer, character varying, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.editphone(IN entityid integer, IN newphone character varying, IN pontycode character varying)
    LANGUAGE plpgsql
    AS $$
begin
	update users.users_phones
	set uspo_number = newPhone
	where uspo_entity_id =  entityId and uspo_ponty_code = pontyCode;
end
$$;


ALTER PROCEDURE users.editphone(IN entityid integer, IN newphone character varying, IN pontycode character varying) OWNER TO postgres;

--
-- Name: editprofile(integer, character varying, character varying, character varying, date, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.editprofile(IN entityid integer, IN username character varying, IN firstname character varying, IN lastname character varying, IN birth date, IN image character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE users.users 
	SET user_name = username,
	    user_first_name = firstname,
	    user_last_name = lastname,
	    user_birth_date = birth,
	    user_photo = image
	WHERE user_entity_id = entityId;
END;
$$;


ALTER PROCEDURE users.editprofile(IN entityid integer, IN username character varying, IN firstname character varying, IN lastname character varying, IN birth date, IN image character varying) OWNER TO postgres;

--
-- Name: signupexternal(character varying, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.signupexternal(IN username character varying, IN password character varying)
    LANGUAGE plpgsql
    AS $$
declare 
	entityId int;
begin
	insert into users.business_entity default values
	returning entity_id into entityId;
	
	insert into users.users(user_entity_id,user_name,user_password)
	values (entityId,username,password);
end;
$$;


ALTER PROCEDURE users.signupexternal(IN username character varying, IN password character varying) OWNER TO postgres;

--
-- Name: signupexternal(character varying, character varying, integer); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.signupexternal(IN username character varying, IN password character varying, IN role integer)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	entityId INT;
	userRole INT;
BEGIN
	INSERT INTO users.business_entity DEFAULT VALUES
	RETURNING entity_id INTO entityId;

	INSERT INTO users.users (user_entity_id, user_name, user_password)
	VALUES (entityId, username, password);

	INSERT INTO users.users_roles (usro_entity_id, usro_role_id)
	VALUES (entityId, role)
	returning usro_role_id into userRole;
	
	update users.users
	set user_current_role = userRole
	where user_entity_id = entityId;

END;
$$;


ALTER PROCEDURE users.signupexternal(IN username character varying, IN password character varying, IN role integer) OWNER TO postgres;

--
-- Name: signupexternal(character varying, character varying, integer, integer, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.signupexternal(IN username character varying, IN password character varying, IN role integer, IN phonecode integer, IN phone character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	entityId INT;
	userRole INT;
BEGIN
	INSERT INTO users.business_entity DEFAULT VALUES
	RETURNING entity_id INTO entityId;

	INSERT INTO users.users (user_entity_id, user_name, user_password)
	VALUES (entityId, username, password);

	INSERT INTO users.users_roles (usro_entity_id, usro_role_id)
	VALUES (entityId, role)
	returning usro_role_id into userRole;
	
	update users.users
	set user_current_role = userRole
	where user_entity_id = entityId;
	
	insert into users.users_phones (uspo_entity_id,uspo_number,uspo_ponty_code)
	values (entityId,phone,phoneCode);

END;
$$;


ALTER PROCEDURE users.signupexternal(IN username character varying, IN password character varying, IN role integer, IN phonecode integer, IN phone character varying) OWNER TO postgres;

--
-- Name: signupexternal(character varying, character varying, integer, character varying, integer); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.signupexternal(IN username character varying, IN password character varying, IN role integer, IN phone character varying, IN phonecode integer)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	entityId INT;
	userRole INT;
BEGIN
	INSERT INTO users.business_entity DEFAULT VALUES
	RETURNING entity_id INTO entityId;

	INSERT INTO users.users (user_entity_id, user_name, user_password)
	VALUES (entityId, username, password);

	INSERT INTO users.users_roles (usro_entity_id, usro_role_id)
	VALUES (entityId, role)
	returning usro_role_id into userRole;
	
	update users.users
	set user_current_role = userRole
	where user_entity_id = entityId;
	
	insert into users.users_phones (uspo_entity_id,uspo_number,uspo_ponty_code)
	values (entityId,phone,phoneCode);

END;
$$;


ALTER PROCEDURE users.signupexternal(IN username character varying, IN password character varying, IN role integer, IN phone character varying, IN phonecode integer) OWNER TO postgres;

--
-- Name: signupexternal(character varying, character varying, integer, character varying, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.signupexternal(IN username character varying, IN password character varying, IN role integer, IN phone character varying, IN phonecode character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	entityId INT;
	userRole INT;
BEGIN
	INSERT INTO users.business_entity DEFAULT VALUES
	RETURNING entity_id INTO entityId;

	INSERT INTO users.users (user_entity_id, user_name, user_password)
	VALUES (entityId, username, password);

	INSERT INTO users.users_roles (usro_entity_id, usro_role_id)
	VALUES (entityId, role)
	returning usro_role_id into userRole;
	
	update users.users
	set user_current_role = userRole
	where user_entity_id = entityId;
	
	insert into users.users_phones (uspo_entity_id,uspo_number,uspo_ponty_code)
	values (entityId,phone,phoneCode);

END;
$$;


ALTER PROCEDURE users.signupexternal(IN username character varying, IN password character varying, IN role integer, IN phone character varying, IN phonecode character varying) OWNER TO postgres;

--
-- Name: signupexternal(character varying, character varying, integer, character varying, character varying, character varying); Type: PROCEDURE; Schema: users; Owner: postgres
--

CREATE PROCEDURE users.signupexternal(IN username character varying, IN password character varying, IN role integer, IN phone character varying, IN phonecode character varying, IN email character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	entityId INT;
	userRole INT;
BEGIN
	INSERT INTO users.business_entity DEFAULT VALUES
	RETURNING entity_id INTO entityId;

	INSERT INTO users.users (user_entity_id, user_name, user_password)
	VALUES (entityId, username, password);

	INSERT INTO users.users_roles (usro_entity_id, usro_role_id)
	VALUES (entityId, role)
	returning usro_role_id into userRole;
	
	update users.users
	set user_current_role = userRole
	where user_entity_id = entityId;
	
	insert into users.users_phones (uspo_entity_id,uspo_number,uspo_ponty_code)
	values (entityId,phone,phoneCode);
	
	insert into users.users_email (pmail_entity_id,pmail_address)
	values (entityId,email);

END;
$$;


ALTER PROCEDURE users.signupexternal(IN username character varying, IN password character varying, IN role integer, IN phone character varying, IN phonecode character varying, IN email character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: address; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.address (
    addr_id integer NOT NULL,
    addr_line1 character varying(255),
    addr_line2 character varying(255),
    addr_postal_code character varying(10),
    addr_spatial_location json,
    addr_modifed_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    addr_city_id integer
);


ALTER TABLE master.address OWNER TO postgres;

--
-- Name: address_addr_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.address_addr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.address_addr_id_seq OWNER TO postgres;

--
-- Name: address_addr_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.address_addr_id_seq OWNED BY master.address.addr_id;


--
-- Name: address_type; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.address_type (
    adty_id integer NOT NULL,
    adty_name character varying(15),
    adty_modified_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE master.address_type OWNER TO postgres;

--
-- Name: address_type_adty_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.address_type_adty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.address_type_adty_id_seq OWNER TO postgres;

--
-- Name: address_type_adty_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.address_type_adty_id_seq OWNED BY master.address_type.adty_id;


--
-- Name: category; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.category (
    cate_id integer NOT NULL,
    cate_name character varying(255),
    cate_cate_id integer,
    cate_modified_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE master.category OWNER TO postgres;

--
-- Name: category_cate_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.category_cate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.category_cate_id_seq OWNER TO postgres;

--
-- Name: category_cate_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.category_cate_id_seq OWNED BY master.category.cate_id;


--
-- Name: city; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.city (
    city_id integer NOT NULL,
    city_name character varying(115),
    city_modified_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    city_prov_id integer
);


ALTER TABLE master.city OWNER TO postgres;

--
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.city_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.city_city_id_seq OWNER TO postgres;

--
-- Name: city_city_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.city_city_id_seq OWNED BY master.city.city_id;


--
-- Name: country; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.country (
    country_code character varying(3) NOT NULL,
    country_name character varying(85),
    country_modified_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE master.country OWNER TO postgres;

--
-- Name: job_role; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.job_role (
    joro_id integer NOT NULL,
    joro_name character varying(55),
    joro_modified_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE master.job_role OWNER TO postgres;

--
-- Name: job_role_joro_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.job_role_joro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.job_role_joro_id_seq OWNER TO postgres;

--
-- Name: job_role_joro_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.job_role_joro_id_seq OWNED BY master.job_role.joro_id;


--
-- Name: job_type; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.job_type (
    joty_id integer NOT NULL,
    joty_name character varying(55)
);


ALTER TABLE master.job_type OWNER TO postgres;

--
-- Name: job_type_joty_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.job_type_joty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.job_type_joty_id_seq OWNER TO postgres;

--
-- Name: job_type_joty_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.job_type_joty_id_seq OWNED BY master.job_type.joty_id;


--
-- Name: modules; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.modules (
    module_name character varying(125) NOT NULL
);


ALTER TABLE master.modules OWNER TO postgres;

--
-- Name: province; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.province (
    prov_id integer NOT NULL,
    prov_code character varying(5),
    prov_name character varying(85),
    prov_modified_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    prov_country_code character varying(3)
);


ALTER TABLE master.province OWNER TO postgres;

--
-- Name: province_prov_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.province_prov_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.province_prov_id_seq OWNER TO postgres;

--
-- Name: province_prov_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.province_prov_id_seq OWNED BY master.province.prov_id;


--
-- Name: route_actions; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.route_actions (
    roac_id integer NOT NULL,
    roac_name character varying(15),
    roac_orderby integer,
    roac_display character(1),
    roac_module_name character varying(125),
    CONSTRAINT route_actions_roac_display_check CHECK ((roac_display = ANY (ARRAY['0'::bpchar, '1'::bpchar])))
);


ALTER TABLE master.route_actions OWNER TO postgres;

--
-- Name: skill_template; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.skill_template (
    skte_id integer NOT NULL,
    skte_skill character varying(256),
    skte_description character varying(256),
    skte_week integer,
    skte_orderby integer,
    skte_modified_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    skty_name character varying(55),
    skte_skte_id integer
);


ALTER TABLE master.skill_template OWNER TO postgres;

--
-- Name: skill_template_skte_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.skill_template_skte_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.skill_template_skte_id_seq OWNER TO postgres;

--
-- Name: skill_template_skte_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.skill_template_skte_id_seq OWNED BY master.skill_template.skte_id;


--
-- Name: skill_type; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.skill_type (
    skty_name character varying(55) NOT NULL
);


ALTER TABLE master.skill_type OWNER TO postgres;

--
-- Name: status; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.status (
    status character varying(15) NOT NULL,
    status_modified_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE master.status OWNER TO postgres;

--
-- Name: business_entity; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE test.business_entity (
    entity_id integer NOT NULL
);


ALTER TABLE test.business_entity OWNER TO postgres;

--
-- Name: business_entity_entity_id_seq; Type: SEQUENCE; Schema: test; Owner: postgres
--

CREATE SEQUENCE test.business_entity_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test.business_entity_entity_id_seq OWNER TO postgres;

--
-- Name: business_entity_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: test; Owner: postgres
--

ALTER SEQUENCE test.business_entity_entity_id_seq OWNED BY test.business_entity.entity_id;


--
-- Name: roles; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE test.roles (
    role_id integer NOT NULL,
    role_name character varying
);


ALTER TABLE test.roles OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: test; Owner: postgres
--

CREATE SEQUENCE test.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test.roles_role_id_seq OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: test; Owner: postgres
--

ALTER SEQUENCE test.roles_role_id_seq OWNED BY test.roles.role_id;


--
-- Name: users; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE test.users (
    user_entity_id integer NOT NULL,
    user_current_role integer
);


ALTER TABLE test.users OWNER TO postgres;

--
-- Name: users_roles; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE test.users_roles (
    usro_entity_id integer NOT NULL,
    usro_role_id integer NOT NULL
);


ALTER TABLE test.users_roles OWNER TO postgres;

--
-- Name: business_entity; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.business_entity (
    entity_id integer NOT NULL
);


ALTER TABLE users.business_entity OWNER TO postgres;

--
-- Name: business_entity_entity_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.business_entity_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.business_entity_entity_id_seq OWNER TO postgres;

--
-- Name: business_entity_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.business_entity_entity_id_seq OWNED BY users.business_entity.entity_id;


--
-- Name: phone_number_type; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.phone_number_type (
    ponty_code character varying(15) NOT NULL,
    ponty_modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE users.phone_number_type OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.roles (
    role_id integer NOT NULL,
    role_name character varying(35) NOT NULL,
    role_type character varying(15),
    role_modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE users.roles OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.roles_role_id_seq OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.roles_role_id_seq OWNED BY users.roles.role_id;


--
-- Name: users; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users (
    user_entity_id integer NOT NULL,
    user_name character varying(15),
    user_password character varying(256),
    user_first_name character varying(50),
    user_last_name character varying(50),
    user_birth_date date,
    user_email_promotion integer DEFAULT 0,
    user_demographic json,
    user_modified_date timestamp with time zone DEFAULT now(),
    user_photo character varying(255),
    user_current_role integer
);


ALTER TABLE users.users OWNER TO postgres;

--
-- Name: users_address; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users_address (
    etad_addr_id integer NOT NULL,
    etad_modified_date timestamp with time zone DEFAULT now(),
    etad_entity_id integer,
    etad_adty_id integer
);


ALTER TABLE users.users_address OWNER TO postgres;

--
-- Name: users_education; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users_education (
    usdu_id integer NOT NULL,
    usdu_entity_id integer NOT NULL,
    usdu_scholl character varying(255),
    usdu_degree character varying(15),
    usdu_field_study character varying(125),
    usdu_graduate_year character varying(4),
    usdu_start_date timestamp with time zone,
    usdu_start_end timestamp with time zone,
    usdu_grade character varying(5),
    usdu_activities character varying(512),
    usdu_description character varying(512),
    usdu_modified_date timestamp with time zone DEFAULT now(),
    CONSTRAINT users_education_usdu_degree_check CHECK (((usdu_degree)::text = ANY ((ARRAY['Bachelor'::character varying, 'Diploma'::character varying])::text[])))
);


ALTER TABLE users.users_education OWNER TO postgres;

--
-- Name: users_education_usdu_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.users_education_usdu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.users_education_usdu_id_seq OWNER TO postgres;

--
-- Name: users_education_usdu_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.users_education_usdu_id_seq OWNED BY users.users_education.usdu_id;


--
-- Name: users_email; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users_email (
    pmail_entity_id integer NOT NULL,
    pmail_id integer NOT NULL,
    pmail_address character varying(50),
    pmail_modified_date timestamp with time zone DEFAULT now()
);


ALTER TABLE users.users_email OWNER TO postgres;

--
-- Name: users_email_pmail_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.users_email_pmail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.users_email_pmail_id_seq OWNER TO postgres;

--
-- Name: users_email_pmail_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.users_email_pmail_id_seq OWNED BY users.users_email.pmail_id;


--
-- Name: users_experiences; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users_experiences (
    usex_id integer NOT NULL,
    usex_entity_id integer NOT NULL,
    usex_title character varying(255),
    usex_profile_headline character varying(512),
    usex_employment_type character varying(15),
    usex_company_name character varying(255),
    usex_city_id integer,
    usex_is_current character(1),
    usex_start_date timestamp with time zone,
    usex_end_date timestamp with time zone,
    usex_industry character varying(15),
    usex_description character varying(512),
    usex_experience_type character varying(15),
    CONSTRAINT users_experiences_usex_employment_type_check CHECK (((usex_employment_type)::text = ANY ((ARRAY['fulltime'::character varying, 'freelance'::character varying])::text[]))),
    CONSTRAINT users_experiences_usex_experience_type_check CHECK (((usex_experience_type)::text = ANY ((ARRAY['company'::character varying, 'certfied'::character varying, 'voluntering'::character varying, 'organization'::character varying, 'reward'::character varying])::text[]))),
    CONSTRAINT users_experiences_usex_is_current_check CHECK ((usex_is_current = ANY (ARRAY['0'::bpchar, '1'::bpchar])))
);


ALTER TABLE users.users_experiences OWNER TO postgres;

--
-- Name: users_experiences_skill; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users_experiences_skill (
    uesk_usex_id integer NOT NULL,
    uesk_uski_id integer NOT NULL
);


ALTER TABLE users.users_experiences_skill OWNER TO postgres;

--
-- Name: users_experiences_usex_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.users_experiences_usex_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.users_experiences_usex_id_seq OWNER TO postgres;

--
-- Name: users_experiences_usex_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.users_experiences_usex_id_seq OWNED BY users.users_experiences.usex_id;


--
-- Name: users_license; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users_license (
    usli_id integer NOT NULL,
    usli_license_code character varying(512),
    usli_modified_date timestamp with time zone DEFAULT now(),
    usli_status character varying(15),
    usli_entity_id integer NOT NULL,
    CONSTRAINT users_license_usli_status_check CHECK (((usli_status)::text = ANY ((ARRAY['Active'::character varying, 'NonActive'::character varying])::text[])))
);


ALTER TABLE users.users_license OWNER TO postgres;

--
-- Name: users_license_usli_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.users_license_usli_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.users_license_usli_id_seq OWNER TO postgres;

--
-- Name: users_license_usli_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.users_license_usli_id_seq OWNED BY users.users_license.usli_id;


--
-- Name: users_media; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users_media (
    usme_id integer NOT NULL,
    usme_entity_id integer NOT NULL,
    usme_file_link character varying(255),
    usme_filename character varying(255),
    usme_filesize integer,
    usme_filetype character varying(15),
    usme_note character varying(55),
    usme_modified_date timestamp with time zone DEFAULT now(),
    CONSTRAINT users_media_usme_filetype_check CHECK (((usme_filetype)::text = ANY ((ARRAY['jpg'::character varying, 'pdf'::character varying, 'word'::character varying])::text[])))
);


ALTER TABLE users.users_media OWNER TO postgres;

--
-- Name: users_media_usme_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.users_media_usme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.users_media_usme_id_seq OWNER TO postgres;

--
-- Name: users_media_usme_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.users_media_usme_id_seq OWNED BY users.users_media.usme_id;


--
-- Name: users_phones; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users_phones (
    uspo_entity_id integer NOT NULL,
    uspo_number character varying(15) NOT NULL,
    uspo_modified_date timestamp with time zone DEFAULT now(),
    uspo_ponty_code character varying(15)
);


ALTER TABLE users.users_phones OWNER TO postgres;

--
-- Name: users_roles; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users_roles (
    usro_entity_id integer NOT NULL,
    usro_role_id integer NOT NULL,
    usro_modified_date timestamp with time zone
);


ALTER TABLE users.users_roles OWNER TO postgres;

--
-- Name: users_skill; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users_skill (
    uski_id integer NOT NULL,
    uski_entity_id integer NOT NULL,
    uski_modified_date timestamp with time zone DEFAULT now(),
    uski_skty_name character varying(15)
);


ALTER TABLE users.users_skill OWNER TO postgres;

--
-- Name: users_skill_uski_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.users_skill_uski_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.users_skill_uski_id_seq OWNER TO postgres;

--
-- Name: users_skill_uski_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.users_skill_uski_id_seq OWNED BY users.users_skill.uski_id;


--
-- Name: address addr_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address ALTER COLUMN addr_id SET DEFAULT nextval('master.address_addr_id_seq'::regclass);


--
-- Name: address_type adty_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address_type ALTER COLUMN adty_id SET DEFAULT nextval('master.address_type_adty_id_seq'::regclass);


--
-- Name: category cate_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.category ALTER COLUMN cate_id SET DEFAULT nextval('master.category_cate_id_seq'::regclass);


--
-- Name: city city_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.city ALTER COLUMN city_id SET DEFAULT nextval('master.city_city_id_seq'::regclass);


--
-- Name: job_role joro_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.job_role ALTER COLUMN joro_id SET DEFAULT nextval('master.job_role_joro_id_seq'::regclass);


--
-- Name: job_type joty_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.job_type ALTER COLUMN joty_id SET DEFAULT nextval('master.job_type_joty_id_seq'::regclass);


--
-- Name: province prov_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.province ALTER COLUMN prov_id SET DEFAULT nextval('master.province_prov_id_seq'::regclass);


--
-- Name: skill_template skte_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.skill_template ALTER COLUMN skte_id SET DEFAULT nextval('master.skill_template_skte_id_seq'::regclass);


--
-- Name: business_entity entity_id; Type: DEFAULT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.business_entity ALTER COLUMN entity_id SET DEFAULT nextval('test.business_entity_entity_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.roles ALTER COLUMN role_id SET DEFAULT nextval('test.roles_role_id_seq'::regclass);


--
-- Name: business_entity entity_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.business_entity ALTER COLUMN entity_id SET DEFAULT nextval('users.business_entity_entity_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.roles ALTER COLUMN role_id SET DEFAULT nextval('users.roles_role_id_seq'::regclass);


--
-- Name: users_education usdu_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_education ALTER COLUMN usdu_id SET DEFAULT nextval('users.users_education_usdu_id_seq'::regclass);


--
-- Name: users_email pmail_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_email ALTER COLUMN pmail_id SET DEFAULT nextval('users.users_email_pmail_id_seq'::regclass);


--
-- Name: users_experiences usex_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_experiences ALTER COLUMN usex_id SET DEFAULT nextval('users.users_experiences_usex_id_seq'::regclass);


--
-- Name: users_license usli_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_license ALTER COLUMN usli_id SET DEFAULT nextval('users.users_license_usli_id_seq'::regclass);


--
-- Name: users_media usme_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_media ALTER COLUMN usme_id SET DEFAULT nextval('users.users_media_usme_id_seq'::regclass);


--
-- Name: users_skill uski_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_skill ALTER COLUMN uski_id SET DEFAULT nextval('users.users_skill_uski_id_seq'::regclass);


--
-- Data for Name: address; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.address (addr_id, addr_line1, addr_line2, addr_postal_code, addr_spatial_location, addr_modifed_date, addr_city_id) FROM stdin;
1	jalan garuda1212	jalan rajawali1212	88880	"antara jalan garuda dan rajawali"	2023-05-27 20:56:26.835595	1
\.


--
-- Data for Name: address_type; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.address_type (adty_id, adty_name, adty_modified_date) FROM stdin;
1	Home	2023-06-05 17:46:50.16928+07
2	Primary	2023-06-05 17:46:50.16928+07
3	Archive	2023-06-05 17:46:50.16928+07
4	Billing	2023-06-05 17:46:50.16928+07
5	Shipping	2023-06-05 17:46:50.16928+07
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.category (cate_id, cate_name, cate_cate_id, cate_modified_date) FROM stdin;
\.


--
-- Data for Name: city; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.city (city_id, city_name, city_modified_date, city_prov_id) FROM stdin;
1	bogor	2023-05-28 13:20:47.679272+07	1
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.country (country_code, country_name, country_modified_date) FROM stdin;
IDN	indonesia	2023-05-28 13:05:16.257821+07
MLY	malaysia	2023-05-28 15:47:21.74727+07
\.


--
-- Data for Name: job_role; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.job_role (joro_id, joro_name, joro_modified_date) FROM stdin;
\.


--
-- Data for Name: job_type; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.job_type (joty_id, joty_name) FROM stdin;
\.


--
-- Data for Name: modules; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.modules (module_name) FROM stdin;
coba
\.


--
-- Data for Name: province; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.province (prov_id, prov_code, prov_name, prov_modified_date, prov_country_code) FROM stdin;
1	JABAR	jawa barat	2023-05-28 13:12:04.626687+07	IDN
\.


--
-- Data for Name: route_actions; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.route_actions (roac_id, roac_name, roac_orderby, roac_display, roac_module_name) FROM stdin;
\.


--
-- Data for Name: skill_template; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.skill_template (skte_id, skte_skill, skte_description, skte_week, skte_orderby, skte_modified_date, skty_name, skte_skte_id) FROM stdin;
\.


--
-- Data for Name: skill_type; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.skill_type (skty_name) FROM stdin;
java
javascript
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.status (status, status_modified_date) FROM stdin;
\.


--
-- Data for Name: business_entity; Type: TABLE DATA; Schema: test; Owner: postgres
--

COPY test.business_entity (entity_id) FROM stdin;
4
5
6
10
11
12
13
15
16
17
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: test; Owner: postgres
--

COPY test.roles (role_id, role_name) FROM stdin;
1	admin
2	user
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: test; Owner: postgres
--

COPY test.users (user_entity_id, user_current_role) FROM stdin;
4	\N
5	\N
6	\N
10	2
11	2
12	2
13	2
15	1
16	1
17	1
\.


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: test; Owner: postgres
--

COPY test.users_roles (usro_entity_id, usro_role_id) FROM stdin;
5	2
6	2
10	2
11	2
12	2
13	2
15	1
16	1
17	1
\.


--
-- Data for Name: business_entity; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.business_entity (entity_id) FROM stdin;
38
39
\.


--
-- Data for Name: phone_number_type; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.phone_number_type (ponty_code, ponty_modified_date) FROM stdin;
Cell	2023-06-05 17:25:24.193494+07
Home	2023-06-05 17:25:31.331537+07
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.roles (role_id, role_name, role_type, role_modified_date) FROM stdin;
2	Candidat	\N	2023-06-04 20:33:16.946347+07
3	Talent	\N	2023-06-04 20:33:49.34136+07
4	Employee	\N	2023-06-04 20:34:07.88529+07
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users (user_entity_id, user_name, user_password, user_first_name, user_last_name, user_birth_date, user_email_promotion, user_demographic, user_modified_date, user_photo, user_current_role) FROM stdin;
38	admin 1	password123	\N	\N	\N	0	\N	2023-06-06 10:58:44.434229+07	\N	2
39	admin 2	password123	\N	\N	\N	0	\N	2023-06-06 10:58:52.958292+07	\N	2
\.


--
-- Data for Name: users_address; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users_address (etad_addr_id, etad_modified_date, etad_entity_id, etad_adty_id) FROM stdin;
\.


--
-- Data for Name: users_education; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users_education (usdu_id, usdu_entity_id, usdu_scholl, usdu_degree, usdu_field_study, usdu_graduate_year, usdu_start_date, usdu_start_end, usdu_grade, usdu_activities, usdu_description, usdu_modified_date) FROM stdin;
\.


--
-- Data for Name: users_email; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users_email (pmail_entity_id, pmail_id, pmail_address, pmail_modified_date) FROM stdin;
38	7	admin@gmail.com	2023-06-06 10:58:44.434229+07
39	8	admin@gmail.com	2023-06-06 10:58:52.958292+07
\.


--
-- Data for Name: users_experiences; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users_experiences (usex_id, usex_entity_id, usex_title, usex_profile_headline, usex_employment_type, usex_company_name, usex_city_id, usex_is_current, usex_start_date, usex_end_date, usex_industry, usex_description, usex_experience_type) FROM stdin;
\.


--
-- Data for Name: users_experiences_skill; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users_experiences_skill (uesk_usex_id, uesk_uski_id) FROM stdin;
\.


--
-- Data for Name: users_license; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users_license (usli_id, usli_license_code, usli_modified_date, usli_status, usli_entity_id) FROM stdin;
\.


--
-- Data for Name: users_media; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users_media (usme_id, usme_entity_id, usme_file_link, usme_filename, usme_filesize, usme_filetype, usme_note, usme_modified_date) FROM stdin;
\.


--
-- Data for Name: users_phones; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users_phones (uspo_entity_id, uspo_number, uspo_modified_date, uspo_ponty_code) FROM stdin;
38	082170841858	2023-06-06 10:58:44.434229+07	Cell
39	082170841858	2023-06-06 10:58:52.958292+07	Cell
\.


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users_roles (usro_entity_id, usro_role_id, usro_modified_date) FROM stdin;
38	2	\N
39	2	\N
\.


--
-- Data for Name: users_skill; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users_skill (uski_id, uski_entity_id, uski_modified_date, uski_skty_name) FROM stdin;
\.


--
-- Name: address_addr_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.address_addr_id_seq', 1, true);


--
-- Name: address_type_adty_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.address_type_adty_id_seq', 5, true);


--
-- Name: category_cate_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.category_cate_id_seq', 1, false);


--
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.city_city_id_seq', 1, true);


--
-- Name: job_role_joro_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.job_role_joro_id_seq', 1, false);


--
-- Name: job_type_joty_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.job_type_joty_id_seq', 1, false);


--
-- Name: province_prov_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.province_prov_id_seq', 1, true);


--
-- Name: skill_template_skte_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.skill_template_skte_id_seq', 1, false);


--
-- Name: business_entity_entity_id_seq; Type: SEQUENCE SET; Schema: test; Owner: postgres
--

SELECT pg_catalog.setval('test.business_entity_entity_id_seq', 17, true);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: test; Owner: postgres
--

SELECT pg_catalog.setval('test.roles_role_id_seq', 2, true);


--
-- Name: business_entity_entity_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.business_entity_entity_id_seq', 39, true);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.roles_role_id_seq', 4, true);


--
-- Name: users_education_usdu_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.users_education_usdu_id_seq', 1, false);


--
-- Name: users_email_pmail_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.users_email_pmail_id_seq', 8, true);


--
-- Name: users_experiences_usex_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.users_experiences_usex_id_seq', 1, false);


--
-- Name: users_license_usli_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.users_license_usli_id_seq', 1, false);


--
-- Name: users_media_usme_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.users_media_usme_id_seq', 1, false);


--
-- Name: users_skill_uski_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.users_skill_uski_id_seq', 1, false);


--
-- Name: address address_addr_line1_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address
    ADD CONSTRAINT address_addr_line1_key UNIQUE (addr_line1);


--
-- Name: address address_addr_line2_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address
    ADD CONSTRAINT address_addr_line2_key UNIQUE (addr_line2);


--
-- Name: address address_addr_postal_code_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address
    ADD CONSTRAINT address_addr_postal_code_key UNIQUE (addr_postal_code);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (addr_id);


--
-- Name: address_type address_type_adty_name_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address_type
    ADD CONSTRAINT address_type_adty_name_key UNIQUE (adty_name);


--
-- Name: address_type address_type_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address_type
    ADD CONSTRAINT address_type_pkey PRIMARY KEY (adty_id);


--
-- Name: category category_cate_name_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.category
    ADD CONSTRAINT category_cate_name_key UNIQUE (cate_name);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (cate_id);


--
-- Name: city city_city_name_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.city
    ADD CONSTRAINT city_city_name_key UNIQUE (city_name);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- Name: country country_country_name_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.country
    ADD CONSTRAINT country_country_name_key UNIQUE (country_name);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_code);


--
-- Name: job_role job_role_joro_name_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.job_role
    ADD CONSTRAINT job_role_joro_name_key UNIQUE (joro_name);


--
-- Name: job_role job_role_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.job_role
    ADD CONSTRAINT job_role_pkey PRIMARY KEY (joro_id);


--
-- Name: job_type job_type_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.job_type
    ADD CONSTRAINT job_type_pkey PRIMARY KEY (joty_id);


--
-- Name: modules modules_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.modules
    ADD CONSTRAINT modules_pkey PRIMARY KEY (module_name);


--
-- Name: province province_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (prov_id);


--
-- Name: province province_prov_code_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.province
    ADD CONSTRAINT province_prov_code_key UNIQUE (prov_code);


--
-- Name: skill_template skill_template_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.skill_template
    ADD CONSTRAINT skill_template_pkey PRIMARY KEY (skte_id);


--
-- Name: skill_type skill_type_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.skill_type
    ADD CONSTRAINT skill_type_pkey PRIMARY KEY (skty_name);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (status);


--
-- Name: business_entity business_entity_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.business_entity
    ADD CONSTRAINT business_entity_pkey PRIMARY KEY (entity_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_entity_id);


--
-- Name: users_roles users_roles_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (usro_entity_id, usro_role_id);


--
-- Name: business_entity business_entity_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.business_entity
    ADD CONSTRAINT business_entity_pkey PRIMARY KEY (entity_id);


--
-- Name: phone_number_type phone_number_type_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.phone_number_type
    ADD CONSTRAINT phone_number_type_pkey PRIMARY KEY (ponty_code);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- Name: users_address users_address_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_address
    ADD CONSTRAINT users_address_pkey PRIMARY KEY (etad_addr_id);


--
-- Name: users_education users_education_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_education
    ADD CONSTRAINT users_education_pkey PRIMARY KEY (usdu_id, usdu_entity_id);


--
-- Name: users_education users_education_usdu_entity_id_key; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_education
    ADD CONSTRAINT users_education_usdu_entity_id_key UNIQUE (usdu_entity_id);


--
-- Name: users_email users_email_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_email
    ADD CONSTRAINT users_email_pkey PRIMARY KEY (pmail_entity_id, pmail_id);


--
-- Name: users_experiences users_experiences_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_experiences
    ADD CONSTRAINT users_experiences_pkey PRIMARY KEY (usex_id, usex_entity_id);


--
-- Name: users_experiences_skill users_experiences_skill_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_experiences_skill
    ADD CONSTRAINT users_experiences_skill_pkey PRIMARY KEY (uesk_usex_id, uesk_uski_id);


--
-- Name: users_experiences users_experiences_usex_entity_id_key; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_experiences
    ADD CONSTRAINT users_experiences_usex_entity_id_key UNIQUE (usex_entity_id);


--
-- Name: users_license users_license_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_license
    ADD CONSTRAINT users_license_pkey PRIMARY KEY (usli_id, usli_entity_id);


--
-- Name: users_license users_license_usli_license_code_key; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_license
    ADD CONSTRAINT users_license_usli_license_code_key UNIQUE (usli_license_code);


--
-- Name: users_media users_media_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_media
    ADD CONSTRAINT users_media_pkey PRIMARY KEY (usme_id, usme_entity_id);


--
-- Name: users_media users_media_usme_entity_id_key; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_media
    ADD CONSTRAINT users_media_usme_entity_id_key UNIQUE (usme_entity_id);


--
-- Name: users_phones users_phones_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_phones
    ADD CONSTRAINT users_phones_pkey PRIMARY KEY (uspo_entity_id, uspo_number);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_entity_id);


--
-- Name: users_roles users_roles_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (usro_entity_id, usro_role_id);


--
-- Name: users_skill users_skill_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_skill
    ADD CONSTRAINT users_skill_pkey PRIMARY KEY (uski_id, uski_entity_id);


--
-- Name: users_skill users_skill_uski_skty_name_key; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_skill
    ADD CONSTRAINT users_skill_uski_skty_name_key UNIQUE (uski_skty_name);


--
-- Name: users users_user_name_key; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT users_user_name_key UNIQUE (user_name);


--
-- Name: users_experiences usex_id_key; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_experiences
    ADD CONSTRAINT usex_id_key UNIQUE (usex_id);


--
-- Name: users_skill uski_id_key; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_skill
    ADD CONSTRAINT uski_id_key UNIQUE (uski_id);


--
-- Name: address addr_city_id; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address
    ADD CONSTRAINT addr_city_id FOREIGN KEY (addr_city_id) REFERENCES master.city(city_id);


--
-- Name: category category_cate_cate_id_fkey; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.category
    ADD CONSTRAINT category_cate_cate_id_fkey FOREIGN KEY (cate_cate_id) REFERENCES master.category(cate_id);


--
-- Name: city city_city_prov_id_fkey; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.city
    ADD CONSTRAINT city_city_prov_id_fkey FOREIGN KEY (city_prov_id) REFERENCES master.province(prov_id);


--
-- Name: province prov_country_code; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.province
    ADD CONSTRAINT prov_country_code FOREIGN KEY (prov_country_code) REFERENCES master.country(country_code);


--
-- Name: route_actions roac_module_name; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.route_actions
    ADD CONSTRAINT roac_module_name FOREIGN KEY (roac_module_name) REFERENCES master.modules(module_name);


--
-- Name: skill_template skill_template_skte_skte_id_fkey; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.skill_template
    ADD CONSTRAINT skill_template_skte_skte_id_fkey FOREIGN KEY (skte_skte_id) REFERENCES master.skill_template(skte_id);


--
-- Name: skill_template skill_template_skty_name_fkey; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.skill_template
    ADD CONSTRAINT skill_template_skty_name_fkey FOREIGN KEY (skty_name) REFERENCES master.skill_type(skty_name);


--
-- Name: users fk_users_current_role; Type: FK CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.users
    ADD CONSTRAINT fk_users_current_role FOREIGN KEY (user_current_role, user_entity_id) REFERENCES test.users_roles(usro_role_id, usro_entity_id);


--
-- Name: users_roles fk_users_roles_entity_id; Type: FK CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.users_roles
    ADD CONSTRAINT fk_users_roles_entity_id FOREIGN KEY (usro_entity_id) REFERENCES test.users(user_entity_id);


--
-- Name: users_roles users_roles_usro_role_id_fkey; Type: FK CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.users_roles
    ADD CONSTRAINT users_roles_usro_role_id_fkey FOREIGN KEY (usro_role_id) REFERENCES test.roles(role_id);


--
-- Name: users users_user_entity_id_fkey; Type: FK CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY test.users
    ADD CONSTRAINT users_user_entity_id_fkey FOREIGN KEY (user_entity_id) REFERENCES test.business_entity(entity_id);


--
-- Name: users fk_business_entity; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT fk_business_entity FOREIGN KEY (user_entity_id) REFERENCES users.business_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_address fk_etad_addr_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_address
    ADD CONSTRAINT fk_etad_addr_id FOREIGN KEY (etad_addr_id) REFERENCES master.address(addr_id);


--
-- Name: users_address fk_etad_adty_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_address
    ADD CONSTRAINT fk_etad_adty_id FOREIGN KEY (etad_adty_id) REFERENCES master.address_type(adty_id);


--
-- Name: users_address fk_etad_entity_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_address
    ADD CONSTRAINT fk_etad_entity_id FOREIGN KEY (etad_entity_id) REFERENCES users.users(user_entity_id);


--
-- Name: users_email fk_pmail_entity_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_email
    ADD CONSTRAINT fk_pmail_entity_id FOREIGN KEY (pmail_entity_id) REFERENCES users.users(user_entity_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_education fk_usdu_entity_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_education
    ADD CONSTRAINT fk_usdu_entity_id FOREIGN KEY (usdu_entity_id) REFERENCES users.users(user_entity_id);


--
-- Name: users fk_users_current_role; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT fk_users_current_role FOREIGN KEY (user_current_role, user_entity_id) REFERENCES users.users_roles(usro_role_id, usro_entity_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_experiences fk_usex_entity_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_experiences
    ADD CONSTRAINT fk_usex_entity_id FOREIGN KEY (usex_id) REFERENCES users.users(user_entity_id);


--
-- Name: users_skill fk_uski_entity_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_skill
    ADD CONSTRAINT fk_uski_entity_id FOREIGN KEY (uski_entity_id) REFERENCES users.users(user_entity_id);


--
-- Name: users_skill fk_uski_skty_name; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_skill
    ADD CONSTRAINT fk_uski_skty_name FOREIGN KEY (uski_skty_name) REFERENCES master.skill_type(skty_name);


--
-- Name: users_license fk_usli_entity_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_license
    ADD CONSTRAINT fk_usli_entity_id FOREIGN KEY (usli_entity_id) REFERENCES users.users(user_entity_id);


--
-- Name: users_media fk_usme_entity_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_media
    ADD CONSTRAINT fk_usme_entity_id FOREIGN KEY (usme_entity_id) REFERENCES users.users(user_entity_id);


--
-- Name: users_phones fk_uspo_entity_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_phones
    ADD CONSTRAINT fk_uspo_entity_id FOREIGN KEY (uspo_entity_id) REFERENCES users.users(user_entity_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_phones fk_uspo_ponty_code; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_phones
    ADD CONSTRAINT fk_uspo_ponty_code FOREIGN KEY (uspo_ponty_code) REFERENCES users.phone_number_type(ponty_code);


--
-- Name: users_roles fk_usro_entity_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_roles
    ADD CONSTRAINT fk_usro_entity_id FOREIGN KEY (usro_entity_id) REFERENCES users.users(user_entity_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_experiences_skill uesk_usex_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_experiences_skill
    ADD CONSTRAINT uesk_usex_id FOREIGN KEY (uesk_usex_id) REFERENCES users.users_experiences(usex_id);


--
-- Name: users_experiences_skill uesk_uski_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_experiences_skill
    ADD CONSTRAINT uesk_uski_id FOREIGN KEY (uesk_uski_id) REFERENCES users.users_skill(uski_id);


--
-- Name: users_roles users_roles_usro_role_id_fkey; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_roles
    ADD CONSTRAINT users_roles_usro_role_id_fkey FOREIGN KEY (usro_role_id) REFERENCES users.roles(role_id);


--
-- Name: users_experiences usex_city_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users_experiences
    ADD CONSTRAINT usex_city_id FOREIGN KEY (usex_city_id) REFERENCES master.city(city_id);


--
-- PostgreSQL database dump complete
--

