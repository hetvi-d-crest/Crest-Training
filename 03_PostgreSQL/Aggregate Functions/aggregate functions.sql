----COUNT

select count(*) from movies;

select count(movie_length) from movies;

-----using count with distinct column

select count(distinct(movie_lang)) from movies;

select count(distinct(director_id)) from movies;

select count(*) from movies where movie_lang = 'English';


-------SUM--------------

select * from movies_revenue;

select sum(revenues_domestic) from movies_revenue;

select sum(revenues_domestic)
from movies_revenue
where revenues_domestic > 200;



select sum(movie_length) from movies where movie_lang = 'English';

----sum with distinct


select sum(distinct revenues_domestic) from movies_revenue;


----Min and MAx functions

select max(movie_length) from movies;

select min(movie_length) from movies;

select max(movie_length) from movies where movie_lang = 'English';


select max(release_date) from movies where movie_lang = 'English';

select min(release_date)
from movies
where movie_lang = 'Chinese';

select max(movie_name) from movies;

-----using greatest and least functions-----------------

select greatest(10,20, 30);

select least(10,20,30);

select greatest('A', 'B', 'C')

select movie_id, revenues_domestic, revenues_international,
greatest(revenues_domestic, revenues_international) as "greatest"
from movies_revenue;



--------Average AVG function

select AVG(movie_length) from movies;


select AVG(movie_length) from movies where movie_lang = 'English';

---with distinct
select AVG(DISTINCT movie_length) from movies where movie_lang = 'English';

select AVG(movie_length),
		SUM(movie_length)
from movies where movie_lang = 'English';


------mathematical operators

select 2+10 as addition;

select 10-2 as subtraction;

select 13/2::numeric(11, 2) as divide;

select 10.5*2.33 as multiply;

select 10%4 as modulus;

select movie_id, revenues_domestic, revenues_international,
(revenues_domestic + revenues_international) as "total revenue"
from movies_revenue;

select movie_id, revenues_domestic, revenues_international,
(revenues_domestic + revenues_international) as "total revenue"
from movies_revenue
order by 4 desc nulls last;


 









