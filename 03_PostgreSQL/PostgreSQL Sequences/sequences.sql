----create Sequence---


CREATE SEQUENCE IF NOT EXISTS test_seq

SELECT nextval('test_seq');

SELECT currval('test_seq');

SELECT setval('test_seq', 100);

---to not increment on nextval---
SELECT setval('test_seq', 200, false);

CREATE SEQUENCE IF NOT EXISTS test_seq2 START WITH 100;


----ALTER SEQ

SELECT nextval('test_seq');

ALTER SEQUENCE test_seq RESTART WITH 100

ALTER SEQUENCE test_seq RENAME TO my_seq;


-----
CREATE SEQUENCE IF NOT EXISTS  test_seq3
INCREMENT 50
MINVALUE 400
MAXVALUE 6000
START WITH 500

SELECT nextval('test_seq3');

---------
CREATE SEQUENCE IF NOT EXISTS test_seq_smallint AS SMALLINT


------SEQUENCE IN DESENDING ORDER

CREATE SEQUENCE SEQ_DEC
increment -1
minvalue 1
maxvalue 3
start 3
cycle;


select nextval('SEQ_DEC');


CREATE SEQUENCE seqdec
increment -1
minvalue 1
maxvalue 3
start 3
no cycle;

select nextval('seqdec');



----drop sequence

drop sequence test_seq3



------attach the sequence to a table column

create table users(
	user_id serial primary key, 
	username varchar(20)
);

insert into users(username)
values ('Crest1');

select * from users;

alter sequence users_user_id_seq restart with 100


----without serial pk
create table users2 (
	user_id int primary key,
	username varchar(50)
);

create sequence users2_user_id
start with 100
owned by users2.user_id;

alter table users2
alter column user_id set default nextval('users2_user_id');

insert into users2(username) values ('Hetvi1');

select * from users2;


----share common sequence among tables

create sequence common_seq start with 100

create table apples(
	fruit_id int default nextval('common_seq') not null,
	fruitname varchar(50)
);


create table mangoes(
	fruit_id int default nextval('common_seq') not null,
	fruitname varchar(50)
);

insert into apples(fruitname)
values('Big Apple');

select * from apples;

insert into mangoes(fruitname)
values('Big Mango');

select * from mangoes;


----create a table with serial datatype

drop table contacts;

create sequence table_seq;

create table contacts(
	contact_id TEXT NOT NULL Default ('ID' || nextval('table_seq')),
	contact_name varchar(150)
);

alter sequence table_seq owned by contacts.contact_id;

insert into contacts(contact_name)
values ('Hetvi1');

select * from contacts;








