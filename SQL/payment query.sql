create table users.business_entity(
entity_id serial primary key
)


create table users.users(
user_entity_id serial primary key
)


create table payment.bank(
bank_entity_id integer primary key references users.business_entity(entity_id),	
bank_code varchar(10) unique,
bank_name varchar(55) unique,
bank_modified_date timestamptz
)


create table payment.fintech(
fint_entity_id integer primary key references users.business_entity(entity_id),
fint_code varchar(10) unique,
fint_name varchar(55) unique,
fint_modified_date timestamptz
)


create table payment.users_account(
usac_bank_entity_id integer references payment.bank(bank_entity_id) references payment.fintech(fint_entity_id),
usac_user_entity_id integer references users.users(user_entity_id),
usac_account_number varchar(25) unique,
usac_saldo numeric,
usac_type varchar(15) CHECK (usac_type in('debet','credit card','payment')),
usac_start_date timestamptz,
usac_end_date timestamptz,
usac_modified_date timestamptz,
usac_status varchar(15) CHECK (usac_status in('active','inactive','blokir')),
primary key (usac_user_entity_id,usac_bank_entity_id)
)


create table payment.transaction_payment(
trpa_id serial primary key ,
trpa_code_number varchar(55) unique,
trpa_order_number varchar(25),
trpa_debet numeric,
trpa_credit numeric,
trpa_type varchar (15) CHECK (trpa_type in('topup','transfer','order','refund')),
trpa_note varchar(255),
trpa_modified_date timestamptz,
trpa_source_id varchar (25) NOT NULL,
trpa_target_id varchar (25) NOT NULL,
trpa_user_entity_id integer references users.users(user_entity_id)
)


CREATE OR REPLACE FUNCTION payment.get_transaction_payment()
RETURNS TABLE (
  trpa_id INTEGER,
  trpa_code_number VARCHAR(55),
  trpa_order_number VARCHAR(25),
  trpa_debet NUMERIC,
  trpa_credit NUMERIC,
  trpa_type VARCHAR(15),
  trpa_note VARCHAR(255),
  trpa_modified_date TIMESTAMPTZ,
  trpa_source_id VARCHAR(25),
  trpa_target_id VARCHAR(25),
  trpa_user_entity_id INTEGER
)
AS $$
BEGIN
  RETURN QUERY
  SELECT tp.trpa_id, tp.trpa_code_number, tp.trpa_order_number, tp.trpa_debet, tp.trpa_credit,
       tp.trpa_type, tp.trpa_note, tp.trpa_modified_date,
       ua_source.usac_account_number AS trpa_source_account_number,
       ua_target.usac_account_number AS trpa_target_account_number,
       tp.trpa_user_entity_id
  FROM payment.transaction_payment tp
  JOIN payment.users_account ua_source ON ua_source.usac_user_entity_id = tp.trpa_source_id
  JOIN payment.users_account ua_target ON ua_target.usac_user_entity_id = tp.trpa_target_id;
END;
$$ LANGUAGE plpgsql;