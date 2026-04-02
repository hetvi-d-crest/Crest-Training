--select first or last 10 recordsin a table

select 
* 
from stocks_prices 
where symbol_id = 1 
order by price_date asc
limit 10;

--first or last record per each group

select
	symbol_id,
	min(price_date)
from stocks_prices
group by symbol_id;

--cube root in postgresSQL

select CBRT(8) as "Cube Root";


select
	close_price,
	CBRT(close_price)
from stocks_prices
where symbol_id = 1
order by price_date desc;





