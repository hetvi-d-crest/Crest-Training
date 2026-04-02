----NOT NULL constraint

create table table_nn(
	id serial primary key,
	tag TEXT NOT NULL
);

select * from table_nn;

insert into table_nn (tag)
values
('Hetvi');


-----UNIQUE constraint

create table table_email(
	id serial primary key,
	email text UNIQUE
);

select * from table_email;

insert into table_email(email)
values('a@b.com');

----UNIQUE on multiple columns

create table table_products(
	id serial primary key,
	product_code VARCHAR(10),
	product_name text
);

---create a UNIQUE constraint

alter table table_products
add constraint unique_product UNIQUE(product_code, product_name);


insert into table_products(product_code, product_name)
values ('A1', 'Apple');

select * from table_products;



------DEFAULT Constraint------------------------


create table employees(
	emp_id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	is_enabled varchar(2) default 'Y'
);

select * from employees;

insert into employees(first_name, last_name)
values('Hetvi', 'Desai');

alter table employees
alter column is_enabled 
set default 'N';

alter table employees
alter column is_enabled
drop default;



--------PRIMARY KEY constraints---------------------


create table items(
	item_id INTEGER primary key,
	item_name varchar(100) not null
);

select * from items;

insert into items(item_id, item_name)
values (1, 'pen');


alter table items
drop constraint items_pkey;

alter table items
add primary key (item_id, item_name);


----composite primary key

create table t_grades(
	course_id varchar(100) not null,
	student_id varchar(100) not null,
	grades int not null,
	primary key(course_id, student_id)
); 

select * from t_grades;

insert into t_grades(course_id, student_id, grades)
values 
('Math', 'S1', 50),
('Science', 'S2', 56),
('English', 'S3', 66),
('Biology', 'S1', 70);

insert into t_grades(course_id, student_id, grades)
values 
('Math', 'S2', 90);

alter table t_grades
drop constraint t_grades_pkey;

alter table t_grades
add constraint t_grades_course_id_student_id_pkey
primary key (course_id, student_id);

----foreign key constraint-----

create table t_products(
	product_id int primary key,
	product_name varchar(100) not null,
	supplier_id int not null
);

create table t_suppliers(
	supplier_id int primary key,
	supplier_name varchar(10) 
);

insert into t_suppliers (supplier_id, supplier_name)
values(1, 'sup1'),
(2, 'sup2');

select * from t_suppliers;

insert into t_products(product_id,product_name, supplier_id)
values
(1, 'pen', 1),
(2, 'paper', 2),
(3, 'marker', 1);

select * from t_products;

drop table t_products;
drop table t_suppliers CASCADE;


create table t_products(
	product_id int primary key,
	product_name varchar(100) not null,
	supplier_id int not null,
	foreign key (supplier_id) references t_suppliers (supplier_id)
);

create table t_suppliers(
	supplier_id int primary key,
	supplier_name varchar(10) 
);


insert into t_suppliers (supplier_id, supplier_name)
values(1, 'sup1'),
(2, 'sup2');

select * from t_suppliers;

insert into t_products(product_id,product_name, supplier_id)
values
(1, 'pen', 1),
(2, 'paper', 2),
(3, 'marker', 1);

select * from t_products;


alter table t_products
drop constraint t_products_supplier_id_fkey;

---CHECK constraint--------



create table staff(
	staff_id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	birth_date Date CHECK(birth_date > '1900-01-01'),
	join_date DATE CHECK(join_date > birth_date),
	salary NUMERIC CHECK(salary > 0)
);


select * from staff;

insert into staff(first_name, last_name, birth_date, join_date, salary)
values 
('Hetvi', 'Desai', '2000-01-01', '2005-01-01', 200);




