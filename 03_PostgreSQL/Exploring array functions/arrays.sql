
SELECT 
	INT4RANGE(1, 6) AS "Default [) = closed - opened",
	NUMRANGE(1.4213, 6.2986, '[]') AS "[] closed-closed",
	DATERANGE('20200101', '20201010', '()') AS "Dates () = opened-opened",
	TSRANGE(LOCALTIMESTAMP, LOCALTIMESTAMP + INTERVAL '8 DAYS', '(]') AS "opened - closed";

---INCLUSION OPERATOR

SELECT 
	ARRAY[1,2,3,4] @> ARRAY[2,3,4] AS "Contains",
	ARRAY['a', 'b'] <@ ARRAY['a', 'b', 'c'] AS "Contained By",
	ARRAY [1,2,3,4] && ARRAY[2,3,4] AS "Its Overlap"


---CONCATENATION

SELECT 
	ARRAY[1,2,3] || ARRAY[4,5,6] AS "Combine Arrays"

SELECT 
	ARRAY_CAT(ARRAY[1,2,3], ARRAY[4,5,6]) AS "Combine arrays vis ARRAY_CAT"

SELECT
	4 || ARRAY[1,2,3] AS "Adding to an ARRAY"

SELECT
	ARRAY_PREPEND(4, ARRAY[1,2,3]) AS "Using Prepend"

SELECT
	ARRAY_APPEND(ARRAY[1,2,3], 4) AS "Using Append"


--ARRAY METADATA FUNCTIONS

--ARRAY_NDIM(array)

SELECT
	ARRAY_NDIMS(ARRAY[[1], [2]]) AS "Dimensions"


SELECT
	ARRAY_DIMS(ARRAY[[1], [2]]) AS "Dimensions"


--ARRAY_LENGTH(array, int)
--return the length of the array , return type = int

select
	array_length(array[1,2,3,4], 1)

select
	array_length(ARRAY[]::INTEGER[], 1)

--ARRAY_LOWER 
--RETURN ARRAY LOWER BOUND, RETURN TYPE = INT

select
	array_lower(array[1,2,3,4], 1)

--array_upper

select
	array_upper(array[1,2,3,4], 1)



--cardinality SAME AS UPPER

select 
	cardinality(array[[1],[2],[3],[4]])

--array search functions

select
	array_position(array['Jan', 'Feb', 'Mar', 'Apr'], 'Feb')

select
	array_position(array[1,2,3,4], 3)

select
	array_positions(array[1,2,3,3,4], 3)


--ARRAY MODIFICATION FUNCTIONS

--ARRAY_CAT TO CONCATENATE TWO ARRAYS

SELECT
	ARRAY_CAT(ARRAY[1,2,3], ARRAY[4,5,6])

--ARRAY_REMOVE TO REMOVE AN ELEMENT

SELECT
	ARRAY_REMOVE(ARRAY[1,2,3,4], 3)

	
SELECT
	ARRAY_REMOVE(ARRAY[1,3,2,3,4], 3)

--ARRAY_REPLACE

SELECT
	ARRAY_REPLACE(ARRAY[1,2,3,4], 3, 7)

SELECT
	ARRAY_REPLACE(ARRAY[1,2,3,3,4], 3, 7)

--ARRAY COMPARISION WITH IN, ALL, ANY, SOME

SELECT
	2 IN (1,2,3,4) AS "Results"

SELECT 	
	7 NOT IN (1,2,3,4) AS "Result"

SELECT 
	25 = ALL(ARRAY[20.,25,30,35,40]) AS "Results"

SELECT
	25 = ALL(ARRAY[25,25]) AS "Results"

SELECT 
	25 = ANY(ARRAY[20.,25,30,35,40]) AS "Results"

	
SELECT 
	25 = SOME(ARRAY[20.,25,30,35,40]) AS "Results"



--FORMATTING AND CONVERTING AN ARRAY

SELECT
	STRING_TO_ARRAY('1,2,3,4', ',')

--CHANGE 'ABC' TO NULL VALUE
SELECT
	STRING_TO_ARRAY('1,2,3,4,ABC', ',', 'ABC')	
	

---ARRAYS IN TABLES

create table teachers(
	teacher_id serial primary key,
	name varchar(100),
	phones TEXT[]
);

create table teachers1(
	teacher_id serial primary key,
	name varchar(100),
	phones TEXT ARRAY
);

--insert data into array

insert into teachers (name, phones)
values
(
	'Hetvi', ARRAY['9998887776', '9273679809']
);

insert into teachers (name, phones)
values
('Linda', '{"9787234323"}'),
('Jeff', '{"8877223345", "7788990066"}');

select * from teachers;

select name, phones[1] from teachers;

select * from teachers
where
	'9999999999' = ANY(phones);


---modify array contents

update teachers
set phones[2] = '9999999999'
where teacher_id = 2;


select * from teachers;

---dimensions for arrays are ignored by postgresql

create table teachers2(
	teacher_id serial primary key,
	name varchar(150),
	phones TEXT ARRAY[1]
);

select * from teachers2;

insert into teachers2 (name, phones)
values
(
	'Hetvi', ARRAY['9998887776', '9273679809']
);

--unnest(anyarray)
--used to expand an array to a set of rows

select 
	teacher_id, 
	name,
	unnest(phones)
from 
	teachers;

select 
	teacher_id, 
	name,
	unnest(phones)
from 
	teachers
order by 3;


----USING MULTIDIMENSIONAL ARRAY

create table students(
	student_id serial primary key,
	student_name varchar(100),
	student_grade integer[][]
);

insert into students (student_name, student_grade) 
values
('s1', '{80,90}');

select * from students;

insert into students (student_name, student_grade) 
values
('s4', '{82,92}');


select student_grade[2] from students;


select * from students where student_grade @> '{90}';

select * from students where student_grade[1] >= 80;



	