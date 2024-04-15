describe users;
describe accounts;


--Table Creation In other File

-- Demo Info
create table test_info(
         id integer,
         description varchar(250)
         );
-- Drop Table
drop table test_info;       

--DDL
--Add Column
alter table users add description varchar(250); 

--Modify Column Definition
alter table users modify description varchar(200);

--Rename Column Name
alter table users rename column description to short_desc;

--Drop The Column From Table
alter table users drop column short_desc;


--DML

-- Data Insertion Into Table In another File

-- Displaying table data using SELECT command 

select * from accounts ;