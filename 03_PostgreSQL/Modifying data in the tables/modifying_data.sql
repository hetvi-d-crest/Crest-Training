create table customers(
	customer_is SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email varchar(150),
	age int
);

select * from customers;

insert into customers (first_name, last_name, email, age) 
values ('Hetvi', 'Desai', 'abc@gmail.com',25);

insert into customers (first_name, last_name)
values 
('JOHN', 'Adams'),
('Linda', 'Abe'),
('Michael', 'Scott');

--Insert a data with quotes

insert into customers (first_name)
values ('Bill ''O Sulivan')

--Use RETURNING to get info on added rows

insert into customers (first_name) values('JOHN') RETURNING *;

insert into customers (first_name)
values('JOHN') returning customer_id;


--Update data into single column
UPDATE customers
SET email = 'hetvi@gmail.com'
WHERE customer_id = 1;

SELECT * from customers;

--Use REturning to get updated row

update customers
set email = 'a@b.com'
where customer_id = 2
returning *;

--Update all records in a table
--update woth no where caluse

update customers
set is_enabled = 'Y'

--Delete records from a table
delete from customers
where customer_id = 6;


--Using UPSERT

--create sample table

create table t_tags(
	id serial primary key,
	tag text unique,
	update_date timestamp default now()
);


--insert some sample data

insert into t_tags (tag) values ('Pen'),('Pencil');

select * from t_tags;


--insert a record and on conflict do nothing

insert into t_tags (tag)
values ('Pen') 
on conflict (tag) 
do 
	nothing;


--insert a record and on conflict set new values

insert into t_tags (tag)
values ('Pen')
on conflict(tag)
do
	update set 
	tag = excluded.tag || '1',
	update_date = NOW();





