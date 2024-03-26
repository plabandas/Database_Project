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