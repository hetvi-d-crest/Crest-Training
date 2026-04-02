--selecting specific columns from a table

--get the first name from the actors table

select first_name from actors;

--Adding ALIAS to a column name

select * from actors;

select first_name as "First Name" from actors;

--the AS keyword is optional

select 
	movie_name "Movie Name",
	movie_lang "Language"
from movies;


--Assigning column alias to an expression

select first_name ||' '|| last_name AS "Fullname" from actors;

--Using  Order By to sort records

select * from movies
order by 
	release_date DESC;


select * from movies
order by
	movie_name DESC,
	release_date DESC;


--Using order by with alias column name

select first_name, last_name "Surname" 
from actors
order by
	"Surname" DESC;

--use order by to sort rows by expressions

select first_name ,
	   length(first_name) as len
from actors
ORDER BY
	len DESC;



--USE cOLUMN NAME OR COLUMN NUMBER IN ORDER BY CLAUSE

select * from actors
order by 
	first_name,
	date_of_birth DESC;

--use column num for sorting 

select 
	first_name,
	last_name,
	date_of_birth
from actors
order by
	1 ASC,
	3 DESC;


--Using ORDER BY with Null value 

create table demo_sorting(
	num INT
);

insert into demo_sorting (num)
values 
(1),
(2),
(3),
(NULL);

select * from demo_sorting;

select * from demo_sorting
order by 
	num NULLS last;

select * from demo_sorting
order by 
	num NULLS first;

select * from demo_sorting
order by 
	num DESC NULLS LAST;

--Using distinct values
select * from movies;

select 
	DISTINCT movie_lang, director_id
from movies
ORDER BY
	1;

--Select all unique records

select distinct * from movies order by movie_id;




	




