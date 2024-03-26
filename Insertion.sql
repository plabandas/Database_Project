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

