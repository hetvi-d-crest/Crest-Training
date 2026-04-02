
select '{
	"title" : "Sunflower"
}'::json

-- use jsonb if we do not want white spaces

select '{
	"title":"Sunflower"
}'::jsonb

---table with jsonb datatype

create table books(
	book_id serial primary key,
	book_info jsonb
);


insert into books(book_info)
values
('{
	"title" : "Book Title 1",
	"author" : "Author1"
}');



insert into books(book_info)
values
('{
	"title" : "Book Title 2",
	"author" : "Author2"
}');


insert into books(book_info)
values
('{
	"title" : "Book Title 3",
	"author" : "Author3"
}');

insert into books(book_info)
values
('{
	"title" : "Book Title 4",
	"author" : "Author4"
}');

select * from books;


--data with double quotes

select book_info -> 'title' from books;

--data withour double quotes

select book_info ->> 'title' from books;


select 
	book_info ->> 'title' as title,
	book_info ->> 'author' as author
from books
where book_info ->> 'author' = 'Author1';


insert into books(book_info)
values
('{
	"title" : "Book Title 5",
	"author" : "Author5"
}');



---|| to update or add new values
update books
set book_info = book_info || '{"author" : "Hetvi"}'

where book_info ->> 'author' = 'Author5';


select * from books;

update books
set book_info = book_info || '{"title" : "Bhagwad Gita"}'

where book_info ->> 'author' = 'Hetvi';


update books
set book_info = book_info || '{"Best Seller" : true}'
where book_info ->> 'author' = 'Hetvi'
returning *;

update books
set book_info = book_info || '{
	"category" : "Mythology",
	"pages" : 360
}'
where book_info ->> 'author' = 'Hetvi'
returning *;



---delete

update books
set book_info = book_info - 'Best Seller'
where book_info ->>'author' = 'Hetvi'
returning *;

---add nested array data in json

update books
set book_info = book_info || '{
	"availability_locations" : ["Mumbai", "Surat"]
}'
where book_info ->> 'author' = 'Hetvi'
returning *


--delete values from array via path #-

update books
set book_info = book_info #- '{availability_locations, 1}'
where book_info ->> 'author' = 'Hetvi'
returning *;


select * from directors;

select row_to_json(directors) from directors;

select row_to_json(t) from
(
	select 
		director_id,
		first_name,
		last_name
	from directors
)as t 

--json_agg to aggregate date

select * from movies

select *,
(
	select json_agg(x) as all_movies from 
	(
		select movie_name from movies
		where director_id = directors.director_id
	)as x
)
from directors;

select 
director_id,
first_name,
last_name,
(
	select json_agg(x) as all_movies from 
	(
		select movie_name from movies
		where director_id = directors.director_id
	)as x
)
from directors;


---build JSON array

select json_build_array(1,2,3,4,5);

select json_build_array('Hi',3,4,5);

select json_build_object('Hi',3,4,5);

select json_build_object('Hetvi', 'a@b.com');

select json_object('{name, email}','{"Hetvi", "a@b.com"}');


--create documents from data

create table directors_docs(
	id serial primary key,
	body jsonb
);


insert into directors_docs (body)
select row_to_json(a)::jsonb from
(
	select 
		director_id,
		first_name,
		last_name,
		date_of_birth,
		nationality,
		(
			select json_agg(x) as all_movies from
			(
				select movie_name
				from movies
				where director_id = directors.director_id
			) as x
		)
	from directors
) as a;


select * from directors_docs;


---null values in json

delete from directors_docs;


insert into directors_docs (body)
select row_to_json(a)::jsonb from
(
	select 
		director_id,
		first_name,
		last_name,
		date_of_birth,
		nationality,
		(
			select case count(x) when 0 then '[]' else json_agg(x) end as all_movies
			from
			(
				select movie_name
				from movies
				where director_id = directors.director_id
			) as x
		)
	from directors
) as a;


select * from directors_docs;


---count total movies for each director

jsonb_array_length

select 
*,
jsonb_array_length(body->'all_movies') as total_movies
from directors_docs
order by jsonb_array_length(body->'all_movies') desc;

--list all the keys within each json row

jsonb_object_keys

select 
*,
jsonb_object_keys(body)
from directors_docs;



---json document to table format

select j.*
from directors_docs, jsonb_to_record(directors_docs.body) j(
	director_id INT,
	first_name varchar(255)
);


---existing operator

--find all first name equal to "John"

select *
from directors_docs
where body->'first_name' ? 'John'


select *
from directors_docs
where body->'first_name' ? 'John'

---containment operator @> to search non text values

select *
from directors_docs
where body @> '{"director_id" : 1}'


select *
from directors_docs
where body @> '{"first_name" : "John"}'


---find a record for movie name Toy Story

select *
from directors_docs
where body -> 'all_movies' @> '[{"movie_name" : "Toy Story"}]'


--find al records where first name starting with capital J

select * 
from directors_docs
where body ->> 'first_name' LIKE 'J%'

--find all records where director_id greater than 2

select * 
from directors_docs
where (body ->> 'director_id')::integer > 2;

--find all records where director_id is in 1,2,3,4,5 and 10.

select * 
from directors_docs
where (body ->> 'director_id')::integer IN (1,2,3,4,5,10);














