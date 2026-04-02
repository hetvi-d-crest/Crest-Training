

--create aan index on order_date and order table

create index idx_orders_order_date on orders (order_date);

create index idx_orders_ship_city on orders (ship_city);

---create index on multiple columns (max 32)

create index idx_orders_customer_id_order_id on orders(customer_id, order_id);

--create a unique index on products table on product_id

create unique index idx_u_products_product_id on products (product_id);

create unique index idx_u_employees_emplyee_id on employees(employee_id);

create unique index idx_u_orders_order_id_customer_id on orders (order_id, customer_id);

create unique index idx_u_employees_employee_id_hire_date on employees(employee_id, hire_date);


select * from employees;

insert into employees (employee_id, first_name, last_name)
values
(1, 's', 'e');


---list all indexes

select * from pg_indexes
where schemaname = 'public'
order by tablename, indexname

--list all indexes of a table

select * from pg_indexes
where tablename = 'orders'
order by tablename, indexname


--size of the table index

select pg_size_pretty(pg_indexes_size('orders'));

--list counts of all indexes

select * 
from pg_stat_all_indexes


select * 
from pg_stat_all_indexes
where schemaname = 'public'
order by relname, indexrelname


----drop an index

drop index idx_suppliers_region;


--SQL statement execution process

---Optimizer

--Seq scan 
explain select * from orders;

--index nodes
--index scan 
explain select * from orders where order_id = 1

--index only scan 
explain select order_id from orders where order_id = 1

show work_mem

--hash joins

explain select * from orders
natural join customers;


--hash index

create index idx_orders_order_date_on on orders
using hash(order_date);


--hash index used for equal operator check
explain select * from orders where order_date = '2020-01-01';

--BRIN index *block range indx)

--explain output options

explain (format json) select * from orders where order_id = 1

[
  {
    "Plan": {
      "Node Type": "Index Scan",
      "Parallel Aware": false,
      "Async Capable": false,
      "Scan Direction": "Forward",
      "Index Name": "idx_u_orders_order_id_customer_id",
      "Relation Name": "orders",
      "Alias": "orders",
      "Startup Cost": 0.28,
      "Total Cost": 8.29,
      "Plan Rows": 1,
      "Plan Width": 90,
      "Disabled": false,
      "Index Cond": "(order_id = 1)"
    }
  }
]


--explain analyze

explain analyze select * from orders where order_id = 1
order by order_id;



 
--understanding query cost model

create table t_big(id serial, name text);

insert into t_big (name)
select 'Hetvi' from generate_series(1, 2000000);


insert into t_big (name)
select 'Adam' from generate_series(1, 2000000);


explain select * from t_big where id = 12345;

show max_parallel_workers_per_gather;

set max_parallel_workers_per_gather to 0;

select pg_relation_size('t_big') / 8192.0;
--21622

show seq_page_cost;
--1

show cpu_tuple_cost;
--0.01

show cpu_operator_cost;
--0.0025

pg_relation_size * seq_page_cost + total_number_of_table_records * cpu_tuple_cost +
total_number_of_table_records * cpu_operator_cost

select 21622 * 1 + 4000000 * 0.01 + 4000000 * 0.0025;

set max_parallel_workers_per_gather to 2;

explain analyze select * from t_big where id = 12345;
--43455.43

create index idx_t_big_id on t_big (id);

select pg_size_pretty(pg_indexes_size('customers'));

select pg_size_pretty(pg_total_relation_size('t_big'));


--using multiple indexes on a single query

explain select * from t_big where id = 20 or id = 40;

create index idx_t_big_name on t_big (name);

explain select * from t_big where name = 'Hetvi' limit 20;

explain select * from t_big where name = 'Hetvi' or name = 'Adam';

explain select * from t_big where name = 'Hetvi1' or name = 'Adam1';


--using organized vs random data

select *  from t_big order by id limit 10;


explain (analyze true, buffers true, timing true)
select * from t_big where id < 10000;

create table t_big_random as select * from t_big order by random();

create index t_big_random_id on t_big_random (id);

select * from t_big_random limit 10;

vacuum analyze t_big_random;

explain (analyze true, buffers true, timing true)
select * from t_big_random where id < 10000;


select 
	tablename, 
	attname,
	correlation
from pg_stats
where
	tablename in ('t_big', 't_big_random')
order by 1, 2

--using index only scan

explain analyze select * from t_big where id = 123456;
--0.163 + 0.184

EXPLAIN ANALYZE SELECT id from t_big where id = 123456;
--0.171 + 0.094

--partial index

select pg_size_pretty(pg_indexes_size('t_big'));

drop index idx_t_big_name;

create index idx_p_t_big_name on t_big (name)
where name not in ('Hetvi', 'Adam');


select * from customers;

update customers
set is_active = 'N'
where 
customer_id in ('ALFKI', 'ANATR')

explain analyze select * from customers 
where is_active = 'N';
--0.101 + 0.094

create index idx_p_customers_inactive on customers(is_active)
where is_active = 'N';


--EXPRESSION INDEXES

CREATE TABLE t_dates AS
select d, repeat(md5(d::text), 10) as padding
from generate_series (timestamp '1800-01-01',
					  timestamp '2100-01-01',
					  interval '1 day') s(d);

vacuum analyze t_dates;

select count(*) from t_dates;

explain analyze select * from t_dates where d between '2001-01-01' and '2001-01-31';
--46.018 without any index


--adding data while indexing
--create index concurrently


create index concurrently idx_t_big_name2 on t_big (name);

select oid, relname, relpages, reltuples,
	i.indisunique, i.indisclustered, indisvalid,
	pg_catalog.pg_get_indexdef(i.indexrelid, 0, true)
	from pg_class c join pg_index i on c.oid = i.indrelid
	where c.relname = 't_big';


select oid, relname, relpages, reltuples,
	i.indisunique, i.indisclustered, indisvalid,
	pg_catalog.pg_get_indexdef(i.indexrelid, 0, true)
	from pg_class c join pg_index i on c.oid = i.indrelid
	where c.relname = 'orders';


select * from orders;

explain select * from orders where ship_country = 'USA';

create index idx_orders_ship_country on orders(ship_country);

update pg_index
set indisvalid = false
where indexrelid = (select oid from pg_class
					where relkind = 'i'
					and relname = 'idx_orders_ship_country');


--rebuilding an index

reindex (verbose) index idx_orders_customer_id_order_id;

reindex (verbose) table orders;


