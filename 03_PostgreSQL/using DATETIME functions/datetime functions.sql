

SHOW DateStyle;

SELECT 
	TO_DATE('2020-01-01', 'YYYY-MM-DD');

SELECT 
	TO_DATE('20200101', 'YYYYMMDD');

SELECT
	TO_TIMESTAMP('2020-01-01 10:10:03', 'YYYY-MM-DD HH:MI:SS')

SELECT
	TO_TIMESTAMP('2020-01-01 10:10:03', 'YYYY-MM-DD HH:MI')

SELECT
	TO_TIMESTAMP('2020-01-01 10:10:03', 'YYYY-MM-DD HH')


SELECT CURRENT_TIMESTAMP;

SELECT CURRENT_TIMESTAMP,
		TO_CHAR('2020-10-10 10:10:03'::TIMESTAMP, 'YYYY Month DD'),
		TO_CHAR('2020-10-10 10:10:03'::TIMESTAMPTZ, 'YYYY Month DD'),
		TO_CHAR('2020-10-10 10:10:03-5:00'::TIMESTAMPTZ, 'YYYY Month DD hh:mm:ss tz'),
		TO_CHAR('2020-10-10 10:10:03-5:00'::TIMESTAMPTZ, 'FMMonth DDth YYYY hh:mm:ss tz');

select movie_name, release_date,
		TO_CHAR(release_date, 'FMMonth DDth, YYYY')
from movies;

--------------------DATE CONSTRUCTION FUNCTION

SELECT 
	make_date(2020,02,02);

SELECT
	MAKE_DATE(2020,1,1)

---make time

select make_time(2, 3, 24.05)

---make timestamp

select make_timestamp(2020,10,10, 5, 30, 8)

-----make interval

select make_interval(2020,10, 10, 01, 8, 20, 45)

select make_interval(days => 10);

select make_interval(months => 4, days =>20, mins => 20)


------make_timestamptz()-------------------------------------------------------------

select * from pg_timezone_names;

-----date value extraction functions

select extract('DAY' FROM CURRENT_TIMESTAMP)

SELECT
	EXTRACT('DAY' FROM CURRENT_TIMESTAMP) AS "Day",
	EXTRACT('MONTH' FROM CURRENT_TIMESTAMP) AS "Month",
	EXTRACT('YEAR' FROM CURRENT_TIMESTAMP) AS "Year";

SELECT
	EXTRACT(EPOCH FROM CURRENT_TIMESTAMP)

------USING MATH OPERATORS WITH DATE---------------


SELECT 
	DATE '20200101' + 10

SELECT 
	DATE '20200101'::date + 10

SELECT
	TIME '23:59:59' + INTERVAL '1 SECOND'

	
SELECT
	TIME '23:59:59' + INTERVAL '10 SECOND'

SELECT CURRENT_TIMESTAMP + '01:01:01'

SELECT INTERVAL '2:00' / 2 AS "1 HOUR"


----------OVERLAPS OPERATOR---------------------

SELECT (DATE '2020-10-10', DATE '2020-02-02') OVERLAPS (DATE '2020-02-01', DATE '2021-01-01');


----DATE/TIME FUNCTIONS----

SELECT CURRENT_DATE, 
		CURRENT_TIME, 
		CURRENT_TIMESTAMP, 
		LOCALTIME, 
		LOCALTIMESTAMP


SELECT CURRENT_DATE, 
		CURRENT_TIME(2), 
		CURRENT_TIMESTAMP, 
		LOCALTIME, 
		LOCALTIMESTAMP(4)


-------POSTGRESQL DATE/TIME FUNCTIONS---------------------


SELECT NOW(),
	TRANSACTION_TIMESTAMP(),
	STATEMENT_TIMESTAMP(),
	CLOCK_TIMESTAMP(),

SELECT TIMEOFDAY();


-------------AGE FUNCTION--------------

SELECT AGE('2020-01-01', '2002-02-02')

SELECT AGE(CURRENT_DATE, TIMESTAMP '2020-01-01')


--------------CURRENT_DATE FUNCTION---------------

SELECT CURRENT_DATE

--------------CURRENT_TIME FUNCTION----------

SELECT CURRENT_TIME

--------------DATE ACCURACY WITH EPOCH-----------------

SELECT
	EXTRACT(EPOCH FROM TIMESTAMPTZ '2020-12-12')-
	EXTRACT(EPOCH FROM TIMESTAMPTZ '2020-10-20')
	AS "DIFFERENCE IS SECONDS"

SELECT
	(EXTRACT(EPOCH FROM TIMESTAMPTZ '2020-12-12')-
	EXTRACT(EPOCH FROM TIMESTAMPTZ '2020-10-20')) /60/60/24
	AS "DIFFERENCE IS HOURS"



-------USEING DATE, TIME, TIMESTAMP IN TABLES----------------

CREATE TABLE times(
	times_id serial primary key,
	start_date DATE,
	start_time TIME,
	start_timestamp timestamp
);


select * from times;

insert into times (start_date, start_time, start_timestamp)
values ('epoch','allballs','-infinity');

insert into times (start_date, start_time, start_timestamp)
values (NOW(),'allballs','-infinity');

-----view and set timezones-------

select * from pg_timezone_names;

show time zone;

set time zone 'Asia/Calcutta';


alter table times
add column end_time time with time zone;

alter table times
add column end_timestamp timestamp with time zone;



insert into times(end_timestamp, end_time)
values('2020-01-01 10:10:10 US/Pacific', '11:30:00+6:00')


insert into times(end_timestamp, end_time)
values('2020-01-01 10:10:10 US/Pacific', '11:30:00+6:00')

insert into times(end_timestamp, end_time)
values('2020-09-020 10:10:10 US/Pacific', '11:30:00+6:00')


select * from times;

--------------------------date part-----------------------

select date_part('year', timestamp '2020-01-01');

select 
	movie_name,
	release_date,
	date_part('month', release_date) as "release month",
	date_part('week', release_date) as "release week"
from movies;


select 
	movie_name,
	release_date,
	date_part('month', release_date) as "release month",
	date_part('week', release_date) as "release week"
from movies
order by 3 asc;


-------------------date_trunc function-----------------------


SELECT
	DATE_TRUNC('hour', TIMESTAMP '2020-10-10 10:30:15') AS  "hour",
	DATE_TRUNC('minute', TIMESTAMP '2020-10-10 10:30:15') AS  "minute",
	DATE_TRUNC('second', TIMESTAMP '2020-10-10 10:30:15') AS  "second";
	
SELECT 
	DATE_TRUNC('month', release_date) as "release_month",
	COUNT (movie_id)
from movies
group by release_month
order by 2 desc;













	
