## Deleting All Tables Of A User
 
 
> Execute This Command
```
BEGIN
   FOR cur_rec IN (SELECT object_name, object_type
                   FROM user_objects
                   WHERE object_type IN
                             ('TABLE',
                              'VIEW',
                              'MATERIALIZED VIEW',
                              'PACKAGE',
                              'PROCEDURE',
                              'FUNCTION',
                              'SEQUENCE',
                              'SYNONYM',
                              'PACKAGE BODY'
                             ))
   LOOP
      BEGIN
         IF cur_rec.object_type = 'TABLE'
         THEN
            EXECUTE IMMEDIATE 'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '" CASCADE CONSTRAINTS';
         ELSE
            EXECUTE IMMEDIATE 'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '"';
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('FAILED: DROP '
                                  || cur_rec.object_type
                                  || ' "'
                                  || cur_rec.object_name
                                  || '"'
                                 );
      END;
   END LOOP;
   FOR cur_rec IN (SELECT * 
                   FROM all_synonyms 
                   WHERE table_owner IN (SELECT USER FROM dual))
   LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM ' || cur_rec.synonym_name;
      END;
   END LOOP;
END;

```
 
## For All Creation & Insertion
> Execute This Command
```

create table users (
  user_id integer primary key, 
  email varchar2(300) not null,
  password varchar2(300) not null,
  name varchar2(300),     
  address varchar2(300)  
);

create table accounts (
  account_id integer primary key,
  user_id integer,
  account_type varchar2(50) not null,
  balance decimal(15, 2) default 0.00,
  foreign key(user_id) references users(user_id) on delete cascade
);

create table categories (
    category_id int primary key,
    name varchar(50) not null,
    type varchar(20) not null check (type in ('Income', 'Expense', 'Transfer'))
);

create table transactions (
    transaction_id integer primary key,
    account_id integer ,
    category_id integer,
    amount decimal(15, 2) not null, 
    tx_date date not null,
    description varchar(200),
    foreign key (account_id) references accounts(account_id) on delete cascade,
    foreign key (category_id) references categories(category_id) 
);

create table budgets (
    budget_id integer primary key,
    user_id integer,
    category_id integer,
    amount decimal(15, 2) not null, 
    startdate date,
    enddate date,
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (category_id) references categories(category_id)
);

create table goals (
    goal_id integer primary key,
    user_id integer,
    category_id integer,
    target_amount decimal(15, 2) not null,
    current_amount decimal(15, 2) default 0.00,
    startdate date,
    enddate date,
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (category_id) references categories(category_id)
);

insert into Users(user_id, email, password, name, address) values(111, 'plaban@gmail.com', 4611, 'Plaban Das','Khulna,Bangladesh');
insert into Users(user_id, email, password, name, address) values(112, 'sumon@gmail.com', 4611, 'Sumon Das','Dhaka,Bangladesh');
insert into Users(user_id, email, password, name, address) values(113, 'niloy@gmail.com', 4611, 'Niloy Das','Satkhira,Bangladesh');
insert into Users(user_id, email, password, name, address) values(114, 'pranto@gmail.com', 4611, 'Pranto Das','Kapilmuni,Bangladesh');
insert into Users(user_id, email, password, name, address) values(115, 'anik@gmail.com', 4611, 'Anik Das','Jashore,Bangladesh');

insert into Accounts(account_id, user_id, account_type, balance) values(11, 111, 'Savings', 10500); 
insert into Accounts(account_id, user_id, account_type, balance) values(12, 112, 'Current', 9500); 
insert into Accounts(account_id, user_id, account_type, balance)values(13, 111, 'Debit Card', 10700); 
insert into Accounts(account_id, user_id, account_type, balance) values(14, 113, 'Credit Card', 12200); 
insert into Accounts(account_id, user_id, account_type, balance) values(15, 113, 'DPS Account', 10300); 
 
insert into Categories(category_id, name, type) values(1, 'Salary', 'Income');
insert into Categories(category_id, name, type) values(2, 'Rent', 'Expense');
insert into Categories(category_id, name, type) values(3, 'Food', 'Expense');
insert into Categories(category_id, name, type) values(4, 'Transport', 'Expense');
insert into Categories(category_id, name, type) values(5, 'Investment', 'Expense');
 
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(21, 14, 1, 500, to_date('01-01-24', 'DD-MM-YY'), 'Salary Transcation Occured');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(22, 14, 1, 200, to_date('01-02-24', 'DD-MM-YY'),  'Salary Transcation Occured 2');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(23, 15, 2, 300, to_date('01-03-24', 'DD-MM-YY'),  'Rent Transcation Occured');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(24, 15, 2, 500, to_date('01-04-24', 'DD-MM-YY'),  'Rent Transcation Occured 2');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(25, 15, 2, 700, to_date('01-05-24', 'DD-MM-YY'),  'Rent Transcation Occured 3'); 
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(26, 11, 1, 500, to_date('01-06-24', 'DD-MM-YY'),  'Salary Transcation Occured 3');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(27, 11, 1, 200, to_date('01-07-24', 'DD-MM-YY'),  'Salary Transcation Occured 4');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(28, 11, 2, 300, to_date('01-08-24', 'DD-MM-YY'),  'Rent Transcation Occured 4');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(29, 11, 2, 500, to_date('01-09-24', 'DD-MM-YY'),  'Rent Transcation Occured 5');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(30, 11, 2, 700, to_date('01-10-24', 'DD-MM-YY'),  'Rent Transcation Occured 6'); 

insert into Budgets(budget_id, user_id, category_id, amount, startdate, enddate) values(31, 114, 1, 1500.00, to_date('2024-06-01', 'YYYY-MM-DD'), to_date('2024-06-30', 'YYYY-MM-DD'));
insert into Budgets(budget_id, user_id, category_id, amount, startdate, enddate) values(32, 114, 1, 600.00, to_date('2024-07-01', 'YYYY-MM-DD'), to_date('2024-07-31', 'YYYY-MM-DD'));
insert into Budgets(budget_id, user_id, category_id, amount, startdate, enddate) values(33, 115, 3, 700.00, to_date('2024-08-01', 'YYYY-MM-DD'), to_date('2024-08-31', 'YYYY-MM-DD'));
insert into Budgets(budget_id, user_id, category_id, amount, startdate, enddate) values(34, 115, 3, 400.00, to_date('2024-09-01', 'YYYY-MM-DD'), to_date('2024-09-30', 'YYYY-MM-DD'));
insert into Budgets(budget_id, user_id, category_id, amount, startdate, enddate) values(35, 111, 4, 1200.00, to_date('2024-10-01', 'YYYY-MM-DD'), to_date('2024-10-31', 'YYYY-MM-DD'));

insert into Goals(goal_id, user_id, category_id, target_amount, current_amount, startdate, enddate) values (41, 111, 1, 5000, 2500, to_date('2024-12-01', 'YYYY-MM-DD'), to_date('2024-12-31', 'YYYY-MM-DD'));
insert into Goals(goal_id, user_id, category_id, target_amount, current_amount, startdate, enddate) values (42, 112, 1, 10000, 7000, to_date('2024-10-01', 'YYYY-MM-DD'), to_date('2024-10-31', 'YYYY-MM-DD'));
insert into Goals(goal_id, user_id, category_id, target_amount, current_amount, startdate, enddate) values (43, 113, 2, 8000, 4000, to_date('2024-06-01', 'YYYY-MM-DD'), to_date('2025-06-30', 'YYYY-MM-DD'));
insert into Goals(goal_id, user_id, category_id, target_amount, current_amount, startdate, enddate) values (44, 114, 2, 12000, 8000, to_date('2024-08-01', 'YYYY-MM-DD'), to_date('2024-08-31', 'YYYY-MM-DD'));
insert into Goals(goal_id, user_id, category_id, target_amount, current_amount, startdate, enddate) values (45, 115, 3, 15000, 12000, to_date('2024-05-01', 'YYYY-MM-DD'), to_date('2024-05-31', 'YYYY-MM-DD'));

```
 
# Let's Start The Project 

<div style="text-align:center">
 <b> Schema Diagram</b>
<img src="https://github.com/plabandas/Database_Project/assets/72873595/9e445ee8-fe5e-4a90-bedd-94d0524fb525"> 
</div>


## Creation Users Table.

> First, we create the table "Users". Here, we can see that the primary key is "UserID"  because it uniquely identifies each row in the table.
```
create table users (
  user_id integer primary key, 
  email varchar2(300) not null,
  password varchar2(300) not null,
  name varchar2(300),     
  address varchar2(300)  
);

``` 

## Creation Accounts Table.
  
```
create table accounts (
  account_id integer primary key,
  user_id integer,
  account_type varchar2(50) not null,
  balance decimal(15, 2) default 0.00,
  foreign key(user_id) references users(user_id) on delete cascade
);

```

## Creation Categories Table.
  
```
create table categories (
    category_id int primary key,
    name varchar(50) not null,
    type varchar(20) not null check (type in ('Income', 'Expense', 'Transfer'))
);

```

## Creation Transactions Table.
  
```
create table transactions (
    transaction_id integer primary key,
    account_id integer ,
    category_id integer,
    amount decimal(15, 2) not null, 
    tx_date date not null,
    description varchar(200),
    foreign key (account_id) references accounts(account_id) on delete cascade,
    foreign key (category_id) references categories(category_id) 
);

```

## Creation Budgets Table.
 
```
create table budgets (
    budget_id integer primary key,
    user_id integer,
    category_id integer,
    amount decimal(15, 2) not null, 
    startdate date,
    enddate date,
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (category_id) references categories(category_id)
);

```

## Creation Goals Table.
 
```
create table goals (
    goal_id integer primary key,
    user_id integer,
    category_id integer,
    target_amount decimal(15, 2) not null,
    current_amount decimal(15, 2) default 0.00,
    startdate date,
    enddate date,
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (category_id) references categories(category_id)
);

``` 

## Data Insertion Into Database

#### Data Insertion Into Users Table: 
```
insert into Users(user_id, email, password, name, address) values(111, 'plaban@gmail.com', 4611, 'Plaban Das','Khulna,Bangladesh');
insert into Users(user_id, email, password, name, address) values(112, 'sumon@gmail.com', 4611, 'Sumon Das','Dhaka,Bangladesh');
insert into Users(user_id, email, password, name, address) values(113, 'niloy@gmail.com', 4611, 'Niloy Das','Satkhira,Bangladesh');
insert into Users(user_id, email, password, name, address) values(114, 'pranto@gmail.com', 4611, 'Pranto Das','Kapilmuni,Bangladesh');
insert into Users(user_id, email, password, name, address) values(115, 'anik@gmail.com', 4611, 'Anik Das','Jashore,Bangladesh');

```
#### Data Insertion Into Accounts Table: 
```
insert into Accounts(account_id, user_id, account_type, balance) values(11, 111, 'Savings', 10500); 
insert into Accounts(account_id, user_id, account_type, balance) values(12, 112, 'Current', 9500); 
insert into Accounts(account_id, user_id, account_type, balance)values(13, 111, 'Debit Card', 10700); 
insert into Accounts(account_id, user_id, account_type, balance) values(14, 113, 'Credit Card', 12200); 
insert into Accounts(account_id, user_id, account_type, balance) values(15, 113, 'DPS Account', 10300); 

```
#### Data Insertion Into Category Table: 
```
insert into Categories(category_id, name, type) values(1, 'Salary', 'Income');
insert into Categories(category_id, name, type) values(2, 'Rent', 'Expense');
insert into Categories(category_id, name, type) values(3, 'Food', 'Expense');
insert into Categories(category_id, name, type) values(4, 'Transport', 'Expense');
insert into Categories(category_id, name, type) values(5, 'Investment', 'Expense');

```
#### Data Insertion Into Transactions Table: 
```
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(21, 14, 1, 500, to_date('01-01-24', 'DD-MM-YY'), 'Salary Transcation Occured');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(22, 14, 1, 200, to_date('01-02-24', 'DD-MM-YY'),  'Salary Transcation Occured 2');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(23, 15, 2, 300, to_date('01-03-24', 'DD-MM-YY'),  'Rent Transcation Occured');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(24, 15, 2, 500, to_date('01-04-24', 'DD-MM-YY'),  'Rent Transcation Occured 2');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(25, 15, 2, 700, to_date('01-05-24', 'DD-MM-YY'),  'Rent Transcation Occured 3'); 
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(26, 11, 1, 500, to_date('01-06-24', 'DD-MM-YY'),  'Salary Transcation Occured 3');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(27, 11, 1, 200, to_date('01-07-24', 'DD-MM-YY'),  'Salary Transcation Occured 4');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(28, 11, 2, 300, to_date('01-08-24', 'DD-MM-YY'),  'Rent Transcation Occured 4');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(29, 11, 2, 500, to_date('01-09-24', 'DD-MM-YY'),  'Rent Transcation Occured 5');
insert into Transactions(transaction_id, account_id, category_id, amount, tx_date, description) values(30, 11, 2, 700, to_date('01-10-24', 'DD-MM-YY'),  'Rent Transcation Occured 6'); 

``` 
#### Data Insertion Into Budgets Table: 
```
insert into Budgets(budget_id, user_id, category_id, amount, startdate, enddate) values(31, 114, 1, 1500.00, to_date('2024-06-01', 'YYYY-MM-DD'), to_date('2024-06-30', 'YYYY-MM-DD'));
insert into Budgets(budget_id, user_id, category_id, amount, startdate, enddate) values(32, 114, 1, 600.00, to_date('2024-07-01', 'YYYY-MM-DD'), to_date('2024-07-31', 'YYYY-MM-DD'));
insert into Budgets(budget_id, user_id, category_id, amount, startdate, enddate) values(33, 115, 3, 700.00, to_date('2024-08-01', 'YYYY-MM-DD'), to_date('2024-08-31', 'YYYY-MM-DD'));
insert into Budgets(budget_id, user_id, category_id, amount, startdate, enddate) values(34, 115, 3, 400.00, to_date('2024-09-01', 'YYYY-MM-DD'), to_date('2024-09-30', 'YYYY-MM-DD'));
insert into Budgets(budget_id, user_id, category_id, amount, startdate, enddate) values(35, 111, 4, 1200.00, to_date('2024-10-01', 'YYYY-MM-DD'), to_date('2024-10-31', 'YYYY-MM-DD'));

```

#### Data Insertion Into Goal Table: 
```
insert into Goals(goal_id, user_id, category_id, target_amount, current_amount, startdate, enddate) values (41, 111, 1, 5000, 2500, to_date('2024-12-01', 'YYYY-MM-DD'), to_date('2024-12-31', 'YYYY-MM-DD'));
insert into Goals(goal_id, user_id, category_id, target_amount, current_amount, startdate, enddate) values (42, 112, 1, 10000, 7000, to_date('2024-10-01', 'YYYY-MM-DD'), to_date('2024-10-31', 'YYYY-MM-DD'));
insert into Goals(goal_id, user_id, category_id, target_amount, current_amount, startdate, enddate) values (43, 113, 2, 8000, 4000, to_date('2024-06-01', 'YYYY-MM-DD'), to_date('2025-06-30', 'YYYY-MM-DD'));
insert into Goals(goal_id, user_id, category_id, target_amount, current_amount, startdate, enddate) values (44, 114, 2, 12000, 8000, to_date('2024-08-01', 'YYYY-MM-DD'), to_date('2024-08-31', 'YYYY-MM-DD'));
insert into Goals(goal_id, user_id, category_id, target_amount, current_amount, startdate, enddate) values (45, 115, 3, 15000, 12000, to_date('2024-05-01', 'YYYY-MM-DD'), to_date('2024-05-31', 'YYYY-MM-DD'));

```

## Commands Prepared For Database Project

#### Describe Tables command
``` 
describe users;
describe accounts;

```

#### Create a table and drop it named test_info
``` 
create table test_info(
         id integer,
         description varchar(250)
         ); 
drop table test_info;   

```
#### Add a coloum into users table
``` 
alter table users add description varchar(250);

``` 
 #### Modify the defination of users table description coloum
``` 
alter table users modify description varchar(200);

```
#### Give the sql command for rename a coloum from a table
``` 
alter table users rename column description to short_desc;

``` 
#### Give a command to drop a coloum
``` 
alter table users drop column short_desc;

```  
#### Write sql command to insert a record into users table
``` 
insert into Users(user_id, email, password, name, address) values(116, 'rahul@gmail.com', 3411, 'Rahul Roy','KUET,Bangladesh');

```
#### Update the email_id whose user_id = 116
``` 
update users set email='rahulroy@gmail.com' where user_id=116;

```
#### Delete the user record whose user_id = 116
``` 
delete from users where user_id=116;

```
#### Find the single Highest transaction from the transaction table
``` 
with max_amount(val) as (select max(amount) from transactions)
select * from transactions,max_amount where transactions.amount=max_amount.val;

```
 #### Count how many transaction happen during the period
``` 
select count(*) from transactions;

```
#### Find how many distinct user_id in accounts table
``` 
select count(distinct user_id) as Number_Of_Users from accounts;

```
#### Fetch the minimum amount value form budget table
``` 
select min(amount) from budgets; 

```
#### Group the records accourding account_id and show average amount of transaction
``` 
select account_id,avg(amount) from transactions group by account_id having avg(amount) > 400;

```
#### Show user_info who have make highest amount single transaction using Nested Subquery
``` 
select * from users where  users.user_id in 
( select accounts.user_id from accounts where accounts.account_id in 
( select transactions.account_id from transactions where transactions.amount = 700));

```
#### Show Users who have surname Das and transaction happened using card
``` 
select * from users where name like '%Das' and users.user_id in (select accounts.user_id from accounts where account_type like '%Card');

```
#### Matches a string with like the string or card transactions
``` 
select * from users where name like 'Sumon____' or users.user_id in (select accounts.user_id from accounts where account_type like '%Card');

```
#### Do not Show which matches with to_D string or transaction with card
``` 
select * from users where not (name like '%to_D%' OR user_id in (select user_id from accounts where account_type like '%Card'));

```
#### Fetch all data from transaction table which description contains sal<any_string>tion<any_string>.
``` 
select * from transactions where description like 'Sal%tion%';

```
 






<p align="center"><span style="color: #FF0000; background-color: #ADD8E6; padding: 5px; border-radius: 5px;">Designed By Plaban Das</span></p>

