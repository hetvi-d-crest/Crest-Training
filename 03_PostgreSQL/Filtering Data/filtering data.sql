--Types of operators: Comparision, Logical and Arithmetic
--AND
select * from movies where movie_lang = 'English' AND age_certificate = '18';

--OR
select * from movies 
where 
	movie_lang = 'English'
	OR movie_lang = 'Chinese'
order by 
	movie_lang;

--combining AND , OR

select * from movies
where
	movie_lang = 'English'
	OR movie_lang = 'Chinese'
	AND age_certificate = '12'
order by
	movie_lang;

select * from movies
where
	(movie_lang = 'English'
	OR movie_lang = 'Chinese')
	AND age_certificate = '12'
order by
	movie_lang;

--movie length greater than 100

select * from movies 
where 
	movie_length > 100
order by 
	movie_length;


select * from movies
where
	release_date > '2000-12-31';
   
select * from movies
where
	movie_lang > 'English'
order by 
	movie_lang;
	
--LIMIT and OFFSET

--Limit is used to limit output records.

select * from movies
order by 
	movie_name
limit 10;


select * from movies
order by
	movie_length DESC
limit 5;

-- all the directors who are old

select * from directors
where nationality = 'American'
order by
	date_of_birth DESC
limit 5
;

select * from actors
where gender = 'F'
order by
	date_of_birth DESC
limit 10;


--Using offset
--LIMIT number OFFSET fromnumber

--list 5 films starting from the 4th one ordered by movie_id

select * from movies
order by 
	movie_id
limit 5 offset 3;

--Use FETCH

select * from movies
fetch first 1 row only;

--top 5 biggest movie by movie length

select * from movies
order by movie_length DESC
fetch first 5 rows only;

select * from directors
order by date_of_birth
fetch first 5 rows only;


--get first 5 movies from the 5th record onwards by long movie length

select * from movies
order by movie_length DESC
fetch first 5 rows only
offset 5;


--IN and NOT IN

select * from movies
where 
	movie_lang IN ('English', 'Chinese', 'Japanese')
order by movie_length;


select * from movies
where director_id NOT IN (13, '10')
order by director_id;



----BETWEEN and NOT BEtWEEN


--all actors birth date between 1991-1995
select * from actors 
where date_of_birth BETWEEN '1991-01-01' AND '1995-12-31'
order by date_of_birth;


--LIKE and ILIKE operators

select 'hello' like 'hello';
select 'hello' like 'h%';
select 'hello' like '%ll_';


--get all the actors where first name starting with 'A'

select * from actors
where first_name like 'A%'
order by first_name;

--ILIKE used when we want to avoid case sensitive

select * from actors 
where first_name ilike '%tim%';


--NULL and NOT NULL

select * from actors
where date_of_birth is NULL
order by date_of_birth;


---COncatenation technique

select 'Hello' || ' ' || 'World' as new_string;


select concat(first_name,' ', last_name) as "Actor Name" from actors;


select concat_ws(', ',first_name, last_name, date_of_birth) as "Actor Name" from actors;






