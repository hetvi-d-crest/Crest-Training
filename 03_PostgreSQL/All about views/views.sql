--create a view
create or replace view v_movie_quick as 
select 
	movie_name,
	movie_length,
	release_date
from movies mv

-- view with all movie directors first name and last name
create or replace view v_movie_directors_all as
select
	mv.movie_id,
	mv.movie_name, 
	mv.movie_length, 
	mv.movie_lang,
	mv.age_certificate,
	mv.release_date,
	mv.director_id,
	d.first_name,
	d.last_name,
	d.date_of_birth,
	d.nationality
from movies mv
inner join directors d on d.director_id = mv.director_id;


--use a view for query datasets

select * from v_movie_quick;

select * from v_movie_directors_all;

--rename a view

alter view v_movie_quick rename to v_movie_quick2;

--delete a view

drop view v_movie_quick;


--using conditions/filters with views
--create a view to list all movies released after 1997.

create or replace view v_movies_after_1997 as
select 
*
from movies
where release_date >= '1997-12-31'
order by release_date desc;

--select all movies with english language only from the view

select 
*
from v_movies_after_1997
where movie_lang = 'English'
order by movie_lang

--select all moies with directors with American and Japanese nationality


select * from v_movie_directors_all
where nationality in ('American', 'Japanese');

--a view using select and union with multiple tables
create view v_all_actors_directors as
select 
	first_name,
	last_name,
	'actor' as people_type
from actors
union all
select 
	first_name,
	last_name,
	'director' as people_type
from directors

select * from v_all_actors_directors


--connecting multiple table with a single view
create view v_movies_directors_revenues as 
select 
	mv.movie_id,
	mv.movie_name,
	mv.movie_length,
	mv.movie_lang,
	mv.age_certificate,
	mv.release_date,

	d.director_id,
	d.first_name,
	d.last_name,
	d.nationality,
	d.date_of_birth,

	mr.revenue_id,
	mr.revenues_domestic,
	mr.revenues_international
	
from movies mv
inner join directors d on d.director_id = mv.director_id
inner join movies_revenue mr on mr.movie_id = mv.movie_id;


select * from v_movies_directors_revenues;

--changing views

--rearrange columns into an existing views
create view v_directors as
select
	first_name,
	last_name
from 
directors;


--add columns to a view at the end

create or replace view v_directors as
select	
	first_name,
	last_name,
	nationality
from directors;


--updatable view of directors table

create or replace view vu_directors as
select
	first_name,
	last_name
from directors

--insert
insert into vu_directors (first_name)
values
('dir1'), ('dir2');

select *from vu_directors;


--delete
delete from vu_directors
where first_name = 'dir2';


--WITH CHECK OPTION

create table countries(
	country_id serial primary key,
	country_code varchar(4),
	city_name varchar(100)
);

insert into countries (country_code, city_name)
values
('US', 'Los Angeles'),
('Us', 'New York'),
('UK', 'London');

select * from countries;


create or replace view v_cities_us as
select 
	country_id,
	country_code,
	city_name
from countries
where country_code = 'US';

select * from v_cities_us;

insert into v_cities_us (country_code, city_name)
values
('UK', 'Greater Manchester');

select * from v_cities_us;


create or replace view v_cities_us as
select 
	country_id,
	country_code,
	city_name
from countries
where country_code = 'US'
with check option;


insert into v_cities_us (country_code, city_name)
values
('UK', 'Leeds');



--using LOCAL and CASCADED in WITH CHECK option

---view with all cities starting with c

create or replace view v_cities_c as
select 
	country_id,
	country_code,
	city_name
from countries
where city_name like 'C%';

select * from v_cities_c;

--with LOCAL
create or replace view v_cities_c_us as
select 
	country_id,
	country_code,
	city_name
from v_cities_c
where country_code = 'US'
with local check option;

insert into v_cities_c_us (country_code, city_name)
values
('US', 'California'),
('US', 'Chicago'),
('US', 'Connecticut');

select * from v_cities_c_us;

insert into v_cities_c_us (country_code, city_name)
values
('US', 'Los Angeles');


--with CASCADED

create or replace view v_cities_c_us as
select 
	country_id,
	country_code,
	city_name
from v_cities_c
where country_code = 'US'
with cascaded check option;

insert into v_cities_c_us (country_code, city_name)
values
('US', 'Miami');


--create a materialized view
--with data
create materialized view if not exists mv_directors as
select 
	first_name,
	last_name
from directors
with data


select * from mv_directors;

--with no data
create materialized view if not exists mv_directors_nodata as
select 
	first_name,
	last_name
from directors
with no data

select * from mv_directors_nodata;

refresh materialized view mv_directors_nodata;

select * from mv_directors_nodata;

--drop materialized view

--changing material view data

select * from mv_directors;
select * from directors;


insert into directors(first_name)
values
('dir1'),
('dir2');

refresh materialized view mv_directors;

delete from mv_directors where first_name = 'dir1';



create materialized view mv_directors2 as
select
	first_name
from directors
with no data;

select * from mv_directors2;


select relispopulated from pg_class where relname = 'mv_directors2';


--refreshing data in materialized view'

create materialized view m_directors_us as
select
	director_id,
	first_name,
	last_name,
	date_of_birth,
	nationality
from directors
where nationality = 'American'
with no data;

select * from m_directors_us;

refresh materialized view m_directors_us;

create unique index idx_u_m_directors_us_director_id on m_directors_us (director_id);

refresh materialized view concurrently m_directors_us;

select * from m_directors_us;

--using materialized view for website page click analytics

create table page_clicks(
	rec_id serial primary key,
	page varchar(200),
	click_time timestamp,
	user_id bigint
);

















