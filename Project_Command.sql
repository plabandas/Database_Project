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

-- Show the average amount of transaction of unique account_id 13
select account_id,avg(amount) from transactions group by account_id having avg(amount) > 400;

-- Show user_info who have make highest amount single transaction Nested Subquery 14
select * from users where  users.user_id in 
( select accounts.user_id from accounts where accounts.account_id in 
( select transactions.account_id from transactions where transactions.amount = 700));

-- Set Membership AND : Show Users who hav surname Das and transaction happened using card 15
select * from users where name like '%Das' and users.user_id in (select accounts.user_id from accounts where account_type like '%Card');

-- Set Membership OR : Matches a string with card transactions 16
select * from users where name like 'Sumon____' or users.user_id in (select accounts.user_id from accounts where account_type like '%Card');

-- Set Membership NOT : Not Show which ( matches with string or transaction with card) 17
select * from users where not (name like '%to_D%' OR user_id in (select user_id from accounts where account_type like '%Card'));


-- String Operations 18
select * from transactions where description like 'Sal%tion%';

-- Natural Join 19
select * from goals natural join users where goals.CURRENT_AMOUNT > 3000;

-- inner Join 20
select * from Users inner join Accounts on Users.USER_ID = Accounts.USER_ID;

-- Right Join Or Right Outer Join Table 21
select * from Transactions right outer Join Accounts on Transactions.account_id = Accounts.account_id;

-- Left Join Or Left Outer Join Table 22
select * from Users left outer Join Accounts on Users.USER_ID = Accounts.USER_ID;

-- PL/SQL variable declaration and print value
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

-- Insert and set default value(PL/SQL)
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

-- Row type(PL/SQL)
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

-- Showing users information using cursor and while loop
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



-- Displaying table data using SELECT command 

select * from accounts ;