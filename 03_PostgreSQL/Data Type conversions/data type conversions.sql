select * from movies;

---no conversion

select * from movies where movie_id = 1;

select * from movies where movie_id = '1';


----conversion 

select * from movies where movie_id = integer '1';


----conversion with CAST

select
	cast('10' as integer);

select 
	cast('10n' as integer);

--string to date

select
	cast ('2020-01-02' as DATE),
	cast ('2020-MAY-03' as DATE);	

--string to boolean
select
	cast('true' as BOOLEAN),
	cast('false' as BOOLEAN),
	cast('0' as BOOLEAN),
	cast('Y' as BOOLEAN);

--string to double

select
	cast ('12.78827' as DOUBLE PRECISION);


-----using :: ------

select
	'10'::INTEGER,
	'2020-01-01'::DATE,
	'False'::BOOLEAN;

---string to interval

select
	'10 minutes'::interval,
	'4 hours'::interval,
	'1 week'::interval,
	'1 month'::interval;



-----Implicit to explicit conversion

SELECT factorial(20);

SELECT factorial(20) as "result";

SELECT CAST(factorial(20) AS BIGINT) as "result";


-----round with numeric

select round(10,4) as "result";

select round(cast(10 as numeric), 4) as "result";


-----cast with text

select substr('12345', 2) as "implicit";

select substr(cast('12345' as text), 4) as "explicit";

------table data conversion

create table ratings(
	rating_id serial primary key,
	rating varchar(1) not null
);

select * from ratings;

insert into ratings (rating)
values 
('A'),
('B'),
('C'),
('D');

insert into ratings (rating)
values 
(1),
(2),
(3),
(4);

----convert all non numeric to 0

select rating_id,
	case 
		when rating~E'^\\d+$' then
			cast(rating as integer)
		else
			0	
		end as 
			rating
from ratings;









	