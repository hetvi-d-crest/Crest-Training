
---UNION-----

select 
	product_id, product_name	
from left_products
union
select 	
	product_id, product_name
from right_products;

--union gives unique, union all gives duplicates as well
insert into right_products(product_id, product_name)
values 
('10', 'Pen');



--combine directors and actors table--

select
	first_name, last_name
from directors
union
select
	first_name, last_name
from actors;


---union with order by--

select 
	first_name,
	last_name,
	'directors' as "tablename"
from directors
union 
select
	first_name, 
	last_name,
	'actors' as "tablename"
from actors
order by first_name ASC;


---union with filters and conditions
--combine all directors where nationality is american, chinese and japanese with all female actors

select
	first_name, last_name,
	'directors' as "tablename"
from directors
where nationality in ('American', 'Chinese', 'Japanese')
union
select
	first_name, last_name,
	'actors' as "tablename"
from actors
where gender = 'F'
order by first_name ASC;


---list of all directors and actors who are borm after 1990.

select
	first_name, last_name,
	date_of_birth,
	'directors' as "tablename"
from directors
where date_of_birth > '1990-12-31'
union
select
	first_name, last_name,
	date_of_birth,
	'actors' as "tablename"
from actors
where date_of_birth > '1990-12-31'
order by date_of_birth



---firstname and lastname of all directors and actors where their first name starts with 'A'.

select
	first_name, last_name,
	'directors' as "tablename"
from directors
where first_name LIKE 'A%'
union
select
	first_name, last_name,
	'actors' as "tablename"
from actors
where first_name LIKE 'A%'
order by first_name;


--union with different number of columns

select col1, col2 from table1
union
select 
	null as col1, col3 from table2;


--INTERSECT--

SELECT
	product_id, product_name
from left_products
INTERSECT
SELECT
	product_id, product_name
from right_products


--intersect first name and last name of directors and actors table.

select
	first_name, last_name
from directors
intersect
select
	first_name, last_name
from actors;
	
--EXCEPT

SELECT 
	product_id, product_name
from left_products
except
SELECT 
	product_id, product_name
from right_products

---EXCEPT first name, last name of directors and actors table

select 
	first_name, last_name
from directors
except
select 
	first_name, last_name
from actors;


--list all first name, last name in directors unless they have the same first name in female actors

select 
	first_name, last_name
from directors
except
select
	first_name, last_name
from actors 
where gender = 'F';

