----UPPER , LOWER AND INITCAP-----------


SELECT UPPER('postgresql');

select upper(first_name) as first_name,
upper(last_name) as last_name
from directors;

------initcap----------------
select initcap('hello world!');

select 
	initcap(
		concat(first_name, ' ', last_name)
	) as full_name
from directors
order by first_name;


----left and right function

select left('ABNCD', 1)

select left('ABNCD', -1)

select left(first_name, 1) as initial
from directors
order by 1;


select left(first_name, 1) as initial,
count(*) as total_initials
from directors
group by 1
order by 1;


--------RIGHT-----------

select right('ABCD', 1);


select right('ABCD', -1);


select last_name , right(last_name, 2)
from directors
where right(last_name, 2) = 'on';



----reverse

select reverse('hetvi');


----split_part----

select SPLIT_PART('1,2,3',',', 2);

----get the release year of all the movies

select 
	movie_name, 
	release_date, 
	split_part(release_date::text, '-', 1) as release_year
from movies;

----TRIM, BTRIM, RTRIM, LTRIM

select 
	trim(
		leading
		from
			'     Hello World'
	),
	trim(
		trailing 
		from
			'Hello World     '
	),
	trim('   Hello World    ');

select(
	trim(
		leading '0'
		from
			cast(00001234 as TEXT)
	)
);

select ltrim('yummy', 'y');
select rtrim('yummy', 'y');
select btrim('yummy', 'y');



------LPAD and RPAD-----

select lpad('database', 15, '*');
select rpad('database', 15, '*');

--------length function


select length('Hello World');


select char_length(' ');
select char_length('');
select char_length(NULL);


----get the total length of all directors full name

select first_name || ' ' || last_name as fullname,
	length(first_name || ' ' || last_name) as full_name_length
from directors
order by 2 desc;


-----Position-----

select position('Hello' in 'Hello World');

---strpos---

select strpos('world bank', 'bank');


select first_name, last_name from directors
where strpos(last_name, 'on') > 0;


----substring-----

select substring('hi how are you doing?' from 1 for 5);


---repeat

select repeat('A', 4);

-----replace function

select replace('Hello World', 'World', 'Hetvi');




