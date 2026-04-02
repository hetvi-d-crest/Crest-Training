

create schema sales;

create schema hr;

--rename schema

alter schema sales 
rename to programming;

--drop a schema

drop schema programming;
drop schema hr;

--move a table to a new schema
alter table hr.orders set schema public;


show search_path;

set search_path to hr, public;
select * from public.orders;

select * from users;

select * from test1;

---schema ownership

alter schema hr owner to hetvi

---duplicate a schema along with all data

create database test_schema;

--create a table called "songs"

create table test_schema.public.songs(
	song_id serial primary key,
	song_title varchar(100)
);

insert into test_schema.public.songs(song_title)
values
('Counting Starts'),
('Mocking Bird');

select * from songs;

pg_dump -d test_schema -h localhost -U postgres -n public > dump.sql

