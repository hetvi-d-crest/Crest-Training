-- Database: mydata

-- DROP DATABASE IF EXISTS mydata;

CREATE DATABASE mydata
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


create table persons(
	person_id serial primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null
);


alter table persons
add column age INT NOT NULL;

SELECT * from persons;

alter table persons
add column nationality varchar(20) not null,
add column email varchar(100) unique;



--rename a table

alter table users
rename to persons;

alter table persons 
rename column age to person_age;

---drop column

alter table persons 
drop column person_age;

alter table persons
add column age varchar(10);


---change data type of a column

alter table persons
alter column age type int
using age::integer;

alter table persons
alter column age type varchar(10);

select * from persons;

-----set a default value to a column

alter table persons
add column is_enabled varchar(1);

alter table persons
alter column is_enabled set default 'Y';


insert into persons (first_name, last_name, nationality)
values ('John', 'Adams', 'US');

---add unique constraint to a column

create table web_links(
	link_id serial primary key,
	link_url varchar(255) not null,
	link_target varchar(20)
);

select * from web_links;

insert into web_links (link_url, link_target) values ('https://www.google.com', '_blank');

alter table web_links
add constraint unique_web_url UNIQUE (link_url);

alter table web_links
add column is_enable varchar(2);

insert into web_links (link_url, link_target, is_enable)
values ('https://www.netflix.com', '_blank', 'Q');

alter table web_links
add check (is_enable in ('Y', 'N')); 

update web_links
set is_enable = 'N'
where link_id = 1;










