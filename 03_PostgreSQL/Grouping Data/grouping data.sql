-----GROUPING DATA-------------

select movie_lang, 
	count(movie_lang) 
from movies
group by movie_lang;


select movie_lang,
	avg(movie_length)
from movies
group by movie_lang;


select age_certificate,
		sum(movie_length)
from movies
group by age_certificate;


select
	movie_lang,
	min(movie_length),
	max(movie_length)
from movies
group by movie_lang;


select 
	movie_lang,
	age_certificate,
	avg(movie_length)
from movies
group by movie_lang, age_certificate
order by movie_lang;


select 
	movie_lang,
	age_certificate,
	avg(movie_length) as "Avg movie length"
from movies
where movie_length > 100
group by movie_lang, age_certificate, movie_length
order by movie_length


select 
	age_certificate,
	avg(movie_length)
from movies
where age_certificate = 'PG'
group by age_certificate;


select 
	nationality,
	count(*)
from directors
group by nationality
order by 2 desc;


-------HAVING--------

select
	movie_lang,
	sum(movie_length)
from movies
group by movie_lang
having sum(movie_length) > 200
order by sum(movie_length)



select
	director_id,
	sum(movie_length)
from movies
group by director_id
having sum(movie_length) >200
order by director_id

-------Handling NULL values with Group By clause-----


create table employee_test(
	emp_id serial primary key,
	emp_name varchar(100),
	emp_dept varchar(100),
	salary INT
);

select * from employee_test;

insert into employee_test(emp_name, emp_dept, salary)
values
('John', 'Finanace', 2500),
('Mary', NULL, 3000),
('Adam', NULL , 4000),
('Bruce', 'Finance', 4000),
('Linda', 'IT', 5000),
('Megan', 'IT', 4000);


select emp_name, emp_dept, salary
from employee_test
order by emp_dept;


select
	emp_dept, 
	count(salary) as total_employees
from employee_test
group by emp_dept;

-----COALESCE(source, '')

select
	coalesce(emp_dept, 'No Department') as Department, 
	count(salary) as total_employees
from employee_test
group by emp_dept
order by emp_dept;











