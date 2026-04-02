----Create Domain 


CREATE DOMAIN addr VARCHAR(100) NOT NULL

CREATE TABLE locations(
	address addr
);

insert into locations (address)
values 
('London'),
('Mumbai');

select * from locations;

create domain positive_numeric INT NOT NULL CHECK  (Value > 0)


create table sample(
	sample_id serial primary key,
	value_num positive_numeric
);

insert into sample(value_num)
values
(0);

select * from sample;


----create domain for postal code check

CREATE DOMAIN postal_code TEXT 
CHECK(
	VALUE ~'^\d{5}$'
	OR VALUE ~'^\d{5}-\d{4}$'
);

CREATE TABLE addresses(
	address_id serial primary key,
	post_code postal_code
);

insert into addresses(post_code)
values ('90815');

select * from addresses;


---- domain for email check

create domain proper_email varchar(150) 
check (value ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');


create table client_names(
	client_id serial primary key,
	email proper_email
);

insert into client_names(email)
values
('a.com');

select * from client_names;



----create Enum domain

create domain valid_color varchar(10)
check(value in('red', 'green', 'blue'));

create table colors(
	color valid_color
);


insert into colors(color)
values ('red');

select * from colors;




-----------get all domain in a schema
select typname
from pg_catalog.pg_type
join pg_catalog.pg_namespace
on pg_namespace.oid = pg_type.typnamespace
where
typtype = 'd' and nspname = 'public';


----drop a domain data type
---drop a domain name
---cascade to delete the dependent table on th domain


drop domain positive_numeric cascade

select * from sample;

------composite data types

---create address composite data type

create type address as (
	city varchar(20),
	country varchar(20)
);

create table companies(
	comp_id serial primary key,
	addresss address
);

insert into companies(addresss)
values (row('London', 'UK'));


select * from companies;

select (addresss).country from companies;

---create a composite "inventory_item" data type

create type inventory_item as(
	product_name varchar(100),
	supplier_id INT,
	price numeric
);

create table inventory (
	inventory_id serial primary key,
	item inventory_item
);

insert into inventory(item)
values(row('paper', 20, 9.99));

select * from inventory;

select (item).product_name from inventory where (item).price < 6.99;


---create currency Enum data type with currency data


create type currency as ENUM ('USD', 'INR', 'EUR')

select 'USD'::currency

alter type currency
add value 'CHF' after 'INR'


create table stocks(
	strock_id serial primary key,
	stock_currency currency
);

insert into stocks(stock_currency) values ('CHF');


select * from stocks;

-----drop type name

create type sample_type as ENUM('ABC', '123');

drop type sample_type;



----Alter data types

create type myaddr as(
	city varchar(50),
	country varchar(20)
);


alter type myaddr rename to my_addr;

alter type my_addr owner to hetvi;

alter type my_addr add attribute street_addr varchar(150);


---alter an enu data type

create type my_colors as ENUM ('green', 'red', 'blue');

alter type my_colors rename value 'red' to 'orange';

select enum_range(NULL::my_colors);

alter type my_colors add value 'red' after 'green';


---update ENUM data type inn production server


create type status_enum as ENUM ('queued', 'waiting', 'running');

create table jobs(
	job_id serial primary key,
	job_status status_enum
);

insert into jobs(job_status)
values
('waiting'),('running');


select * from jobs;

update jobs set job_status = 'running' where job_status = 'waiting';

alter type status_enum rename to status_enum_old;

create type status_enum as ENUM ('queued', 'done', 'running');

alter table jobs
alter column job_status type status_enum
using job_status::text::status_enum;

drop type status_enum_old;


-------ENUM data type with a default value in a table

create type status as enum ('pending', 'approved', 'declined');

create table cron_jobs(
	job_id INT,
	job_status status default 'pending'
);

insert into cron_jobs (job_id)
values(2);

insert into cron_jobs (job_id, job_status)
values(3, 'approved');

select * from cron_jobs;



