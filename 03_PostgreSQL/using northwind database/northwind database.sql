--orders shipping to USA or France

select * from orders order by ship_country;

select 
*
from orders
where ship_country = 'USA'
	or ship_country = 'France'
order by ship_country;

--total no of orders shipped to usa or france

select 
	ship_country,
	count(*)
from orders
where ship_country = 'USA'
	or ship_country = 'France'
group by ship_country
order by ship_country;


--orders shipping to any countries in latin america

select
*
from orders
where ship_country in ('Brazil', 'Mexico', 'Argentina', 'Venezuela')
order by ship_country


--order total amount per each total line

total_amount = (unit_price * quantity) - discount;

select
	order_id,
	product_id,
	unit_price,
	quantity,
	(unit_price * quantity) - discount as total_amount_order
from order_details
order by 5;


--find the first and the latest order dates

select min(order_date) as min_order_date,
max(order_date) as max_order_date
from orders;


--total products in each categories

select
	c.category_name,
	count(*) as total_products
from products p 
inner join categories c on c.category_id = p.category_id
group by 1
order by 2 desc;

--list products that need re-ordering

select
	product_id, 
	product_name,
	units_in_stock, 
	reorder_level
from products where
	units_in_stock <= reorder_level
order by 4 desc;

---top 5 highest freight charges

select
	ship_country,
	max(freight)
from orders
group by ship_country
order by 2 desc
LIMIT 5;

--TOP 5 highest freight charges in year 1997

select
	ship_country,
	max(freight)
from orders
where order_date between '1997-01-01' and '1997-12-31'
group by ship_country
order by 2 desc
LIMIT 5;

--top 5 highest freight charges last year

select
	ship_country,
	max(freight)
from orders
where 
	extract ('Y' from order_date) = extract ('Y' from (select max(order_date) from orders))
group by ship_country
order by 2 desc
LIMIT 5;

--customers with no orders

select
*
from customers c
left join orders o on o.customer_id = c.customer_id
where 
	o.customer_id is NULL

--top customers with their total order amount spend

SELECT
	c.customer_id,
	c.company_name,
	sum((od.unit_price * od.quantity) - od.discount) as total_amount 
FROM customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
group by
	c.customer_id,
	c.company_name
order by 3 desc
limit 10;

--orders with many lines of itemas

select 
	order_id,
	count(*)
from order_details
group by order_id
order by 2;


--orders with double entry line item

select
	order_id,
	quantity
from
	order_details
where quantity > 60
group by order_id, quantity
having count(*) > 1


--list all late shipped orders

select 
* 
from orders
where shipped_date > required_date;


--countries with customers or suppliers

select 
country
from
customers
union
select
country
from
suppliers
order by country;


--customers with multiple orders
--within 4 days perios

with next_order_date as
(
	select 
		customer_id,
		order_date,
		lead(order_date , 1) over (partition by customer_id order by customer_id, order_date) 
		as next_order_date
	from orders
)
select 
	customer_id,
	order_date,
	next_order_date,
	(next_order_date - order_date) as days_between_orders
from next_order_date
where (next_order_date - order_date) <= 4
 

	

--first order from each country

with orders_by_country as
(
	select
		ship_country,
		order_id,
		order_date,
		row_number() over(partition by ship_country order by ship_country, order_date)
		country_row_number
	from orders
)
select
	ship_country,
	order_id,
	order_date
from orders_by_country
where country_row_number = 1
order by ship_country


	










