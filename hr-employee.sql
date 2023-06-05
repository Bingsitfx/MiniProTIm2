
CREATE TABLE hr.employee(
	emp_entity_id integer PRIMARY KEY,
	emp_emp_number varchar(25) UNIQUE,
	emp_national_id varchar(25) UNIQUE,
	emp_birth_date date NOT NULL,
	emp_marital_status char(1) check (emp_marital_status in ('M', 'S')),
	emp_gender char(1) check (emp_gender in ('M', 'F')),	
	emp_hire_date date,
	emp_salaried_flag char(1) check (emp_salaried_flag in('0','1')),
	emp_vacation_hours SMALLINT,
	emp_sickleave_hours SMALLINT,
	emp_current_flag smallint check (emp_current_flag in('0','1')),
	emp_emp_entity_id INT,
	emp_modified_date TIMESTAMPTZ,
	emp_type varchar(15) check (emp_type in('internal', 'outsource')),
	emp_joro_id INT,
	CONSTRAINT fk_emp_entity_id
      FOREIGN KEY(emp_emp_entity_id) 
      REFERENCES hr.employee(emp_entity_id)
)

// kalo ada table users.users

alter table hr.employee
add constraint fk_user_entity_id
foreign key(emp_entity_id)
references users.users(user_entity_id);

//kalo ada table master.job_role

alter table hr.employee
add constraint fk_emp_joro_id
foreign key(emp_joro_id)
references master.job_role(joro_id);


CREATE TABLE hr.employee_client_contract(
	ecco_id serial,
	ecco_entity_id INT,
	ecco_contract_no VARCHAR(55),
	ecco_contract_date date NOT NULL,
	ecco_start_date date NOT NULL,
	ecco_end_date date NOT NULL,
	ecco_notes VARCHAR(512),
	ecco_modified_date TIMESTAMPTZ,
	ecco_media_link VARCHAR(255),
	ecco_status varchar(15) check (ecco_status in('onsite', 'online', 'hybrid')),
	ecco_joty_id INT,
	ecco_account_manager INT,
	ecco_clit_id INT,
	CONSTRAINT fk_ecco_entity_id
      FOREIGN KEY(ecco_entity_id)
      REFERENCES hr.employee(emp_entity_id),
	PRIMARY KEY (ecco_id, ecco_entity_id)
)


// kalo ada table master.job_type

alter table hr.employee_client_contract
add constraint fk_ecco_joty_id
foreign key(ecco_joty_id)
references master.job_type(joty_id);   

// kalo ada table job.client

alter table hr.employee_client_contract
add constraint fk_ecco_clit_id
foreign key(ecco_clit_id)
references job.client(clit_id); 

// kalo ada table yang berisikan account_manager

alter table hr.employee_client_contract
add constraint fk_ecco_account_manager
foreign key(ecco_account_manager)
references hr.employee(emp_joro_id); 

CREATE TABLE hr.department(
	dept_id serial PRIMARY KEY,
	dept_name varchar(50) UNIQUE,
	dept_modified_date TIMESTAMPTZ
)

CREATE TABLE hr.employee_department_history(
	edhi_id serial,
	edhi_entity_id int,
	edhi_start_date TIMESTAMPTZ,
	edhi_end_date TIMESTAMPTZ,
	edhi_modified_date TIMESTAMPTZ,
	edhi_dept_id INT,
	CONSTRAINT fk_edhi_entity_id
      FOREIGN KEY(edhi_entity_id)
      REFERENCES hr.employee(emp_entity_id),
	CONSTRAINT fk_edhi_dept_id
      FOREIGN KEY(edhi_dept_id)
      REFERENCES hr.department(dept_id),
	PRIMARY KEY (edhi_id, edhi_entity_id)
)

CREATE TABLE hr.employee_pay_history(
	ephi_entity_id INT,
	ephi_rate_change_date TIMESTAMPTZ,
	ephi_rate_salary numeric,
	ephi_pay_frequence smallint,
	ephi_modified_date TIMESTAMPTZ,
	CONSTRAINT fk_ephi_entity_id
      FOREIGN KEY(ephi_entity_id)
      REFERENCES hr.employee(emp_entity_id),
	PRIMARY KEY (ephi_entity_id, ephi_rate_change_date)
)