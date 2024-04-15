describe users;
describe accounts;


--Table Creation In other File

-- Demo Info
create table test_info(
         id integer,
         description varchar(250)
         );
-- Drop Table 1
drop table test_info;       

--DDL
--Add Column 2
alter table users add description varchar(250); 

--Modify Column Definition 3
alter table users modify description varchar(200);

--Rename Column Name 4
alter table users rename column description to short_desc;

--Drop The Column From Table 5
alter table users drop column short_desc;


--DML

-- Data Insertion Into Table In another File
-- Insert A Record Into Users Table 6
insert into Users(user_id, email, password, name, address) values(116, 'rahul@gmail.com', 3411, 'Rahul Roy','KUET,Bangladesh');


-- Update Data From A Table 7
update users set email='rahulroy@gmail.com' where user_id=116;

-- Delete Row From Table 8
delete from users where user_id=116;

-- Find Single Highest Transaction using with clause 9
with max_amount(val) as (select max(amount) from transactions)
select * from transactions,max_amount where transactions.amount=max_amount.val;


-- how many row exist in transactions table. 10
select count(*) from transactions;

-- How many distinct user_id in accounts table 11
select count(distinct user_id) as Number_Of_Users from accounts;

-- What min amount budget have been created 12
select min(amount) from budgets; 

-- Show the average amount of transaction of unique account_id
select account_id,avg(amount) from transactions group by account_id having avg(amount) > 400;

-- Show user_info who have make highest amount single transaction Nested Subquery
select * from users where  users.user_id in 
( select accounts.user_id from accounts where accounts.account_id in 
( select transactions.account_id from transactions where transactions.amount = 700))



-- Displaying table data using SELECT command 

select * from accounts ;