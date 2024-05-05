describe users;
describe accounts;


--Table Creation In other File

-- Demo Info 
-- create a temporary table command
create table test_info(
         id integer,
         description varchar(250)
         );
-- Drop Table 1
-- Give a command to drop dest_info table
drop table test_info;       

--DDL
--Add Column 2
--Add a coloum into users table
alter table users add description varchar(250); 

--Modify Column Definition 3
--Modify the defination of users table description coloum
alter table users modify description varchar(200);

--Rename Column Name 4
-- Give the sql command for rename a coloum from a table
alter table users rename column description to short_desc;

--Drop The Column From Table 5
-- Give a command to drop a coloum
alter table users drop column short_desc;


--DML

-- Data Insertion Into Table In another File
-- Insert A Record Into Users Table 6
-- Write sql command to insert a record into users table
insert into Users(user_id, email, password, name, address) values(116, 'rahul@gmail.com', 3411, 'Rahul Roy','KUET,Bangladesh');


-- Update Data From A Table 7
-- Update the email_id whose user_id = 116
update users set email='rahulroy@gmail.com' where user_id=116;

-- Delete Row From Table 8
-- Delete the user record whose user_id = 116
delete from users where user_id=116;

-- Find Single Highest Transaction using with clause 9
-- Find the single Highest transaction from the transaction table
with max_amount(val) as (select max(amount) from transactions)
select * from transactions,max_amount where transactions.amount=max_amount.val;


-- how many row exist in transactions table. 10
-- Count how many transaction happen during the period
select count(*) from transactions;

-- How many distinct user_id in accounts table 11
-- Find how many distinct user_id in accounts table
select count(distinct user_id) as Number_Of_Users from accounts;

-- What min amount budget have been created 12
-- Fetch the minimum amount value form budget table
select min(amount) from budgets; 

-- Show the average amount of transaction of unique account_id 13
-- Group the records accourding account_id and show average amount of transaction
select account_id,avg(amount) from transactions group by account_id having avg(amount) > 400;

-- Show user_info who have make highest amount single transaction Nested Subquery 14
-- Show user_info who have make highest amount single transaction using Nested Subquery
select * from users where  users.user_id in 
( select accounts.user_id from accounts where accounts.account_id in 
( select transactions.account_id from transactions where transactions.amount = 700));

-- Set Membership AND :  15
-- Show Users who have surname Das and transaction happened using card
select * from users where name like '%Das' and users.user_id in (select accounts.user_id from accounts where account_type like '%Card');

-- Set Membership OR :  16
-- Matches a string with like the string or card transactions
select * from users where name like 'Sumon____' or users.user_id in (select accounts.user_id from accounts where account_type like '%Card');

-- Set Membership NOT : 17
-- Do not Show which matches with to_D string or transaction with card
select * from users where not (name like '%to_D%' OR user_id in (select user_id from accounts where account_type like '%Card'));


-- String Operations 18
-- Fetch all data from transaction table which description contains sal<any_string>tion<any_string>.
select * from transactions where description like 'Sal%tion%';

-- Natural Join 19
-- Perform natural join of goals and users table where goals.current_amount>3000
select * from goals natural join users where goals.CURRENT_AMOUNT > 3000;

-- inner Join 20
-- Perform inner join of accounts and users table accoding to user_id
select * from Users inner join Accounts on Users.USER_ID = Accounts.USER_ID;

-- Right Join Or Right Outer Join Table 21
-- Perform right outer join on transactions and accounts according to account_id
select * from Transactions right outer Join Accounts on Transactions.account_id = Accounts.account_id;

-- Left Join Or Left Outer Join Table 22
-- Perform left outer join on Users and accounts according to user_id
select * from Users left outer Join Accounts on Users.USER_ID = Accounts.USER_ID;

-- PL/SQL variable declaration and print value 23
-- Write the PL/SQL code for variable declaration and print the value
set serveroutput on;
declare
    v_user_id Users.User_ID%TYPE; 
    v_email Users.Email%TYPE;
    v_password Users.Password%TYPE;
    v_name Users.Name%TYPE; 
    v_address Users.Address%TYPE;
begin
        select user_id, email, password, name, address 
        into v_user_id, v_email, v_password, v_name, v_address  from Users
        where user_id = 111;
        
        -- Display user data 
        DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
        DBMS_OUTPUT.PUT_LINE('Password: ' || v_password);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_name); 
        DBMS_OUTPUT.PUT_LINE('Address: ' || v_address);
end;
/ 

-- Insert and set default value(PL/SQL) 24
-- Write the PL/SQL code for inserting and setting the default value
set serveroutput on;
declare
    v_user_id Users.User_ID%TYPE:=116; 
    v_email Users.Email%TYPE:='rahul@gmail.com';
    v_password Users.Password%TYPE:='2342';
    v_name Users.Name%TYPE:='Rahul Roy'; 
    v_address Users.Address%TYPE:='BUET, Dhaka';
begin
        insert into users values(v_user_id, v_email, v_password, v_name, v_address);
END;
/ 

-- Row type(PL/SQL) 25
-- User Row Type for printing the value of record from users table where id=115
set serveroutput on;
declare
    my_row users%rowtype;
begin
        select user_id, email, password, name, address 
        into my_row.user_id, my_row.email, my_row.password, my_row.name, my_row.address  from Users
        where user_id = 115;
        
        -- Display user data 
        DBMS_OUTPUT.PUT_LINE('Email: ' || my_row.email);
        DBMS_OUTPUT.PUT_LINE('Password: ' || my_row.password); 
END;
/ 

-- Showing users information using cursor and while loop 26
-- Show users information using cursor and while loop
set serveroutput on;
declare
    v_user Users%ROWTYPE;
    cursor user_cursor is select * from Users;
begin
    open user_cursor; -- Open the cursor 
    fetch user_cursor into v_user; -- Fetch user data into v_user
    
    while user_cursor%found  LOOP 
    
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_user.Name);
        FETCH user_cursor INTO v_user; -- Actualli like i++
        
    end loop;
 
    close user_cursor;
END;
/

-- Show Name Of Users Note : Use For Loop and Array with extend function 27
-- Show Name Of Users Note : Use For Loop and Array with extend function
set serveroutput on
declare 
  counter number;
  name2 USERS.NAME%type;
  
  TYPE my_array IS VARRAY(5) OF users.name%type; 
  all_names my_array:=my_array();
begin
  counter:=1;
  for x in 111..115 
  loop
    select Name into name2 from Users where user_id=x;
    all_names.EXTEND();
    all_names(counter):=name2;
    counter:=counter+1;
  end loop;
  
  counter:=1;
  WHILE counter<=all_names.COUNT 
    LOOP 
    DBMS_OUTPUT.PUT_LINE(all_names(counter)); 
    counter:=counter+1;
  END LOOP;
end;
/

-- Show the account name information using IF/ELSEIF/ELSE in PL/SQL 28
-- Show the account name information using IF/ELSEIF/ELSE in PL/SQL
DECLARE 
  counter number;
  name2 USERS.NAME%type;
  
  type my_array is varray(5) of users.name%type; 
  all_names my_array:=my_array('Name 1', 'Name 2', 'Name 3', 'Name 4', 'Name 5');  -- ekhane size fix kora diyachi; and initialized with dummy names
BEGIN
   counter := 1;
   FOR x IN 111..115  
   LOOP
      select name into name2 from users where user_id=x;
      if name2='Plaban Das' 
        then
        dbms_output.put_line(name2||' is '||'is my account');
      elsif name2='Sumon Das'  
        then
        dbms_output.put_line(name2||' is '||'my brother account');
      elsif name2='Niloy Das'
        then
        dbms_output.put_line(name2||' is my another brother account name');
      else
        dbms_output.put_line(name2||' is '||' recently active user');
        end if;
   END LOOP;
END;


-- Count Total number of accounts of unique user using function 29
-- Count Total number of accounts of unique user using function
create or replace function count_occurrences(
    user_account in varchar2,
    target_account in varchar2, 
    user_id_val in varchar2
)
return number
is
    l_count number;
begin
 
    select count(*) into l_count from ACCOUNTS where user_id = user_id_val;

    return l_count;
 
end count_occurrences;
/

-- Calling Functions
set serveroutput on
declare 
    v_user_111_count number;
    v_user_112_count number;
    v_user_113_count number; 
begin 
    v_user_111_count := count_occurrences('Users', 'Accounts', '111');
    DBMS_OUTPUT.PUT_LINE('User 111 count: ' || v_user_111_count);
 
    v_user_112_count := count_occurrences('Users', 'Accounts', '112');
    DBMS_OUTPUT.PUT_LINE('User 112 count: ' || v_user_112_count);
 
    v_user_113_count := count_occurrences('Users', 'Accounts', '113');
    DBMS_OUTPUT.PUT_LINE('User 113 count: ' || v_user_113_count); 
END;
/

-- Make a procedure sothat you can find all count of records of first three table with max transaction at a time 30
-- Make a procedure sothat you can find all count of records of first three table with max transaction at a time 
create or replace procedure my_proc(
  var1 out number,
  var2 out number,
  var3 out number,
  var4 out number
)
AS
  t_show CHAR(30);
BEGIN
  t_show := 'from procedure: ';
  select count(*) into var1 from users;
  select count(*) into var2 from accounts;
  select count(*) into var3 from transactions;
  select max(amount) into var4 from TRANSACTIONS;
   
  DBMS_OUTPUT.PUT_LINE(t_show);
  DBMS_OUTPUT.PUT_LINE('Total number of users : ' || var1);
  DBMS_OUTPUT.PUT_LINE('Number of Total Accounts : ' || var2);
  DBMS_OUTPUT.PUT_LINE('Transactions happened : ' || var3 || ' times');
  DBMS_OUTPUT.PUT_LINE('Max value of single transaction : ' || var4);
   
END;
/


set serveroutput on
declare 
count_1 number; 
count_2 number; 
count_3 number; 
count_4 number;  
begin
my_proc(count_1, count_2, count_3, count_4);
end;
/


-- Create a trigger which will insert value in a new table with just account_id and amount when transaction is happened
create table transactions_by_name(
     account_id integer,
     amount integer
); 

set serveroutput on
create or replace trigger my_transaction_trigger
after insert on transactions
for each row 
begin 
    insert into transactions_by_name(account_id, amount) values(:new.account_id, :new.amount);
end;  

insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(31, 11, 2, 700, to_date('01-10-24', 'DD-MM-YY'),  'Rent Transcation Occured 6'); 
select * from transactions_by_name;




-- Displaying table data using SELECT command 

select * from accounts ;


select users.name from users where users.USER_ID = 
( select user_id from accounts where accounts.account_id = 
( select transactions.account_id from transactions where transactions.TRANSACTION_ID = 30 ));