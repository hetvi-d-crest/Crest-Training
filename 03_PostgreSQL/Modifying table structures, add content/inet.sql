create table table_netaddr(
	id serial primary key,
	ip INET
);

insert into table_netaddr (ip)
values
('4.32.821.243'),
('4.35.921.243'),
('4.45.201.243');

select * from table_netaddr;


select 
	ip,
	set_masklen(ip, 24) as inet_24
from table_netaddr;


select 
	ip,
	set_masklen(ip, 24) as inet_24,
	set_masklen(ip::cidr, 24) as cidr_24
from table_netaddr;


select 
	ip,
	set_masklen(ip, 24) as inet_24,
	set_masklen(ip::cidr, 24) as cidr_24,
	set_masklen(ip::cidr, 27) as cidr_27,
	set_masklen(ip::cidr, 28) as cidr_28
from table_netaddr;