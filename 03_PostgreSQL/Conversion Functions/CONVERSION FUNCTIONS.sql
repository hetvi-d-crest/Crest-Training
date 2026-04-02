-----convert using TO_CHAR

select To_CHAR(10000030,
			  '9,99,9999,9');


-----view movie release data in DD-MM-YYYY---

select release_date,
	TO_CHAR(release_date, 'DD-MM-YYYY'),
	TO_CHAR(release_date, 'Dy, MM, YYYY')
from movies;


----add currency symbol

select movie_id,
	revenues_domestic, TO_CHAR(revenues_domestic, '$99999D99')
from movies_revenue;


-----TO_NUMBER-------------

SELECT TO_NUMBER(
		'1234.23',
		'9999.'
);

-----TO DATE----

SELECT TO_DATE(
	'2010/10/22',
	'YYYY/MM/DD'
);


------TO TIMESTAMP


SELECT TO_TIMESTAMP('2020  May', 'YYYY MON');

SELECT TO_TIMESTAMP('2020-10-28 10:30:25', 'YYYY-MM-DD HH:MI:SS');









