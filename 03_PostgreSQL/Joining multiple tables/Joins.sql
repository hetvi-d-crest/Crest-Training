

select
	movies.movie_id,
	movies.movie_name,
	movies.director_id,
	directors.first_name
from movies
inner join directors
on movies.director_id = directors.director_id;


select
	m.movie_id,
	m.movie_name,
	m.director_id,
	m.movie_lang,
	d.first_name
from movies m
inner join directors d
on m.director_id = d.director_id
where m.movie_lang = 'English';


select
	mv.*,
	d.*
from movies mv
inner join directors d
on mv.director_id = d.director_id;


------INNER JOIN with Using---------


select * from movies
inner join directors using(director_id);

----join two or more tables

select * from movies
inner join movies_revenue using(movie_id)
inner join directors using (director_id)



select * from movies
inner join movies_revenue using(movie_id)
inner join directors using (director_id)
where movies.movie_lang = 'Japanese';


----filtering using joins-------
select
	mv.movie_name,
	d.first_name, d.last_name,
	mr.revenues_domestic
from movies mv
inner join directors d on mv.director_id = d.director_id
inner join movies_revenue mr on mr.movie_id = mv.movie_id
where
	mv.movie_lang in ('English', 'Chinese', 'Japanese')
and
	mr.revenues_domestic > 100
order by 4 desc;



select 
	mv.movie_name,
	d.first_name, d.last_name,
	mr.revenues_domestic, mr.revenues_international,
	(mr.revenues_domestic + mr.revenues_international) as "Total Revenues"
from movies mv
inner join directors d on mv.director_id = d.director_id
inner join movies_revenue mr on mr.movie_id = mv.movie_id
order by 6 desc nulls last
limit 5;

----10 most profitable movies between 2005 and 2008---

select 
	mv.movie_name, mv.movie_lang, mv.release_date,
	d.first_name, d.last_name,
	mr.revenues_domestic, mr.revenues_international,
	(mr.revenues_domestic + mr.revenues_international)
from movies mv
inner join directors d on d.director_id = mv.director_id
inner join movies_revenue mr on mr.movie_id = mv.movie_id
where mv.release_date between '2005-01-01' and '2008-12-31'
order by 8 desc nulls last 
limit 10


-----INNER JOIN tables with different column data type---------
------USe CAST-----------------------
create table t1(test INT);

create table t2(test varchar(10));


select * from t1
inner join t2 on t1.test = cast(t2.test as INT);


insert into t1(test)
values (1), (2);

insert into t2(test)
values('aa'), ('ab');



--------LEFT JOIN----------------------------

create table left_products(
	product_id serial primary key,
	product_name varchar(100)
);

create table right_products(
	product_id serial primary key,
	product_name varchar(100)
);

insert into left_products(product_id, product_name)
values
(1, 'computers'),
(2, 'laptops'),
(3, 'monitors'),
(5, 'keyboards');

select * from left_products;

insert into right_products(product_id, product_name)
values
(1, 'computers'),
(2, 'laptops'),
(3, 'monitors'),
(4, 'pen'),
(7,'papers');

select * from right_products;


select
*
from left_products lp
left join right_products rp on lp.product_id = rp.product_id;



--list all the movies with directors first and last name and movie name.

insert into directors(first_name, last_name, date_of_birth, nationality)
values
('James', 'David', '2010-10-10', 'American');

------54 records----------
select
	d.first_name,
	d.last_name, 
	mv.movie_name
from directors d
left join movies mv on d.director_id = mv.director_id;


------53 records--------------
select
	d.first_name,
	d.last_name, 
	mv.movie_name
from movies mv
left join directors d on d.director_id = mv.director_id;


------count all movies for each director-------

select
	d.first_name, d.last_name,
	count(*) as "Total movies"
from directors d
left join movies mv on d.director_id = mv.director_id
group by d.first_name, d.last_name
order by 3 desc;


----get all the movies with age cretification for all directors where nationalities are america, chinese and japanese

select 
	mv.movie_name,
	mv.age_certificate,
	d.nationality
from directors d
left join movies mv on mv.director_id = d.director_id
where d.nationality in ('American', 'Chinese', 'Japanese');



--total revenues done by each film for each director---


select 
	d.first_name, d.last_name,
	sum (mr.revenues_domestic + mr.revenues_international) as "Total revenues"
from directors d
left join movies mv on mv.director_id = d.director_id
left join movies_revenue mr on mv.movie_id = mr.movie_id
group by d.first_name, d.last_name
order by 3 desc nulls last;


-------RIGHT JOIN---------


select * 
from left_products
right join right_products on left_products.product_id = right_products.product_id;


--list all the movies with directors first and last names, movie name

select
	d.first_name,
	d.last_name,
	mv.movie_name
from directors d
right join movies mv on d.director_id = mv.director_id;


-----FULL JOIN------

select * 
from left_products
FULL join right_products on left_products.product_id = right_products.product_id;


-----joining multiple tables----


select *
from movies mv
join directors d on d.director_id = mv.director_id
join movies_revenue mr on mr.movie_id = mv.movie_id;


select *
from actors a
join movies_actors ma on ma.actor_id = a.actor_id
join movies mv on mv.movie_id = ma.movie_id
join directors d on d.director_id = mv.director_id
join movies_revenue mr on mr.movie_id = mv.movie_id;

-----Self join----

select * from left_products t1
inner join left_products t2 on t1.product_id = t2.product_name


--self join to find all pairs of movies that have same movie length

select 
	t1.movie_name,
	t2.movie_name,
	t1.movie_length
from movies t1
inner join movies t2 on t1.movie_length = t2.movie_length
and t1.movie_name != t2.movie_name
order by t1.movie_length desc


----CROSS JOINS----

select *
from left_products
cross join right_products;

---this will mimic cross join
select * 
from left_products
inner join right_products on true;


--Natural join-----
select *
from left_products
natural join right_products;

select *
from left_products
natural left join right_products;

select *
from left_products
natural right join right_products;


select *
	from movies
	natural join directors;

--append tables with different columns--

create table table2(
	add_date DATE,
	col1 INT,
	col2 INT,
	col3 INT,
	col4 INT,
	col5 INT
);

insert into table1(add_date, col1, col2, col3)
values
('2020-01-01', 1,2,3),
('2020-01-02', 4,5,6);

select * from table1;


insert into table2(add_date, col1, col2, col3, col4, col5)
values
('2020-01-01',NULL, 7,8,9,10),
('2020-01-02', 11,12,13,14,15),
('2020-01-03', 16,17,18,19,20);


select * from table1;
select * from table2;

---COALESCE---

select
	coalesce(t1.add_date, t2.add_date) as "add_date",
	coalesce(t1.col1, t2.col1) as col1,
	coalesce(t1.col2, t2.col2) as col2,
	coalesce(t1.col3, t2.col3) as col3,
	t2.col4,
	t2.col5
from table1 t1 full outer join table2 t2 on (t1.add_date = t2.add_date);





