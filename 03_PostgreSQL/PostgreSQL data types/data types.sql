---BOOLEAN data type
----True, False or NULL

create table table_boolean(
	product_id SERIAL PRIMARY KEY,
	is_available BOOL NOT NULL
);


insert into table_boolean 
(is_available) values ('TRUE'),
('False'),
('yes'),
('no'),
('y'),
('n'),
('1'),
('0'),
('Y'),
('N');

select * from table_boolean;

alter table table_boolean
alter column is_available
set default '0';


---CHAR, VARCHAR and TEXT

select cast('Adnan' as character(10)) as "Name";
select 'Hetvi'::character(10) as "Name";


--DATE

create table table_date(
	id serial primary key,
	employee_name varchar(100) not null,
	hire_date DATE NOT NULL,
	add_date DATE DEFAULT CURRENT_DATE
);


insert into table_date (employee_name, hire_date) values
('Hetvi', '2026-01-01'),
('John', '2025=02-02');


select * from table_date;


create table table_time(
	id serial primary key,
	class_name varchar(100) not null,
	start_time time not null,
	end_time time not null
);

insert into table_time (class_name, start_time, end_time) 
values
	('Math', '08:00:00', '09:00:00'),
	('English', '09:01:00', '10:00:00');

select * from table_time;

select time '12:00:00' - time '04:00:00' as result;

select current_time,
current_time + interval '-2 hours' as result;


--timezone


create table table_time_zone(
	ts timestamp,
	tstz timestamptz
);

insert into table_time_zone (ts, tstz)
values
	('2020-10-10:10:10-01', '2020-10-10:10:10-01');

select * from table_time_zone;
SHOW TIMEZONE;

SET TIMEZONE = 'America/New_York';

SELECT CURRENT_TIMESTAMP;



-----uuid-------------------------------


create extension if not exists "uuid-ossp";

select uuid_generate_v1();

select uuid_generate_v4();


create table table_uuid(
	product_id uuid default uuid_generate_v1(),
	product_name varchar(100) not null
);


insert into table_uuid (product_name)
values ('TFC');

select * from table_uuid;


alter table table_uuid
alter column product_id
set default uuid_generate_v4();


----ARRAYS-------


CREATE TABLE table_array(
	id SERIAL,
	name varchar(100),
	phone text []
);

insert into table_array (name, phone)
values ('Hetvi', ARRAY['(562) 939-6554' , '9727306390']);

select * from table_array;

select name , phone[1]
from table_array;



--------HSTORE----------------

CREATE EXTENSION IF NOT EXISTS hstore;


CREATE TABLE table_hstore(
	book_id serial primary key,
	title varchar(100) not null,
	book_info hstore
);


insert into table_hstore (title, book_info)
values
	('Title1', '
		"publisher" => "ABC publisher2",
		"paper_cost" => "20.00",
		"e_cost" => "11.85"
	')


select * from table_hstore;

select book_info -> 'publisher' as "publisher",from table_hstore;



-------JSON------------


create table table_json(
	id serial primary key,
	docs json
);

insert into table_json (docs)
values
('[1,2,3,4,5,6]'),
('[2,3,4,5,6,7]'),
('{"key":"value"}');

select * from table_json

select docs from table_json;

select * from table_json 
where docs @> '2';

alter table table_json
alter column docs type jsonb;


create index on table_json using GIN (docs jsonb_path_ops);






















