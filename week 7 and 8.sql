create database supplier;
use supplier;
create table supplier (sid int primary key,sname varchar(30),address varchar(50));
create table parts (pid int primary key,pname varchar(30),color varchar(20));
create table catalog (sid int,pid int,cost decimal(10,2),primary key (sid, pid),foreign key (sid) references supplier(sid),foreign key (pid) references parts(pid));
insert into supplier values(10001, 'acme widget', 'bangalore'),(10002, 'johns', 'mysore'),(10003, 'reliance', 'chennai'),(10004, 'abc suppliers', 'mumbai');
insert into parts values(20001, 'book', 'red'),(20002, 'pen', 'blue'),(20003, 'pencil', 'red'),(20004, 'mobile', 'black'),(20005, 'charger', 'red');
insert into catalog values(10001, 20001, 50),(10001, 20002, 20),(10001, 20003, 10),(10001, 20004, 100),(10001, 20005, 30),(10002, 20001, 60),(10002, 20002, 25),(10002, 20003, 15),(10002, 20005, 35),(10003, 20001, 55),(10003, 20003, 12),(10003, 20004, 110),(10004, 20001, 70),(10004, 20002, 30);
select distinct p.pname
from parts p
join catalog c
on p.pid = c.pid;
select s.sname
from supplier s
where not exists (
select *
from parts p
where not exists (
select *
from catalog c
where c.sid = s.sid
and c.pid = p.pid
)
);
select s.sname
from supplier s
where not exists (
select *
from parts p
where p.color = 'red'
and not exists (
select *
from catalog c
where c.sid = s.sid
and c.pid = p.pid
)
);
select p.pname
from parts p
join catalog c
on p.pid = c.pid
join supplier s
on c.sid = s.sid
where s.sname = 'acme widget'
and not exists (
select *
from catalog c2
where c2.pid = p.pid
and c2.sid <> s.sid
);
select distinct c1.sid
from catalog c1
where c1.cost > (
select avg(c2.cost)
from catalog c2
where c2.pid = c1.pid
);
select c.pid, s.sname
from catalog c
join supplier s
on c.sid = s.sid
where c.cost = (
select max(c2.cost)
from catalog c2
where c2.pid = c.pid
);
select p.pname, s.sname, c.cost
from parts p
join catalog c
on p.pid = c.pid
join supplier s
on c.sid = s.sid
where c.cost = (
select max(cost)
from catalog
);
select s.sname
from supplier s
where not exists (
select *
from catalog c
join parts p
on c.pid = p.pid
where c.sid = s.sid
and p.color = 'red'
);
select s.sname, sum(c.cost) as total_value
from supplier s
join catalog c
on s.sid = c.sid
group by s.sid, s.sname;
SELECT p.pname, c.pid, c.sid, s.sname
FROM parts p
JOIN catalog c ON p.pid = c.pid
JOIN supplier s ON c.sid = s.sid
WHERE s.sname = 'acme widget';
SELECT *
FROM catalog c
JOIN supplier s ON c.sid = s.sid
WHERE s.sname = 'acme widget';

