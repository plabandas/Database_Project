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
CREATE TABLE Users (
  User_ID INTEGER PRIMARY KEY,
  Username VARCHAR2(255) NOT NULL,
  Email VARCHAR2(255) NOT NULL,
  Password VARCHAR2(255) NOT NULL,
  Name VARCHAR2(255),  
  DOB DATE,  -- Added missing comma here
  Address CLOB  -- Corrected data type 
);

CREATE TABLE Accounts (
  Account_ID INTEGER PRIMARY KEY,
  User_ID INTEGER,
  Account_Type VARCHAR2(50) NOT NULL,
  Balance DECIMAL(15, 2) DEFAULT 0.00,
  FOREIGN KEY(User_ID) references Users(User_ID)
);
CREATE TABLE Transactions (
    Transaction_ID INTEGER PRIMARY KEY,
    Account_ID INTEGER ,
    Tx_Date DATE NOT NULL,
    Amount DECIMAL(15, 2) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Description VARCHAR(200),
    FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);
CREATE TABLE Categories (
    Category_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Type VARCHAR(20) NOT NULL CHECK (Type IN ('Income', 'Expense', 'Transfer'))
);
CREATE TABLE Budgets (
    Budget_ID INTEGER PRIMARY KEY,
    User_ID INTEGER,
    Category_ID INTEGER,
    Amount DECIMAL(15, 2) NOT NULL,
    Period VARCHAR(20) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID)
);
CREATE TABLE Goals (
    Goal_ID INTEGER PRIMARY KEY,
    User_ID INTEGER,
    Target_Amount DECIMAL(15, 2) NOT NULL,
    Current_Amount DECIMAL(15, 2) DEFAULT 0.00,
    Deadline DATE,
    Goal_Type VARCHAR(50) NOT NULL,  
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

insert into Users(User_ID, Username, Email, Password, Name, DOB, Address) values(111, 'plaban', 'plaban@gmail.com', 4611, 'Plaban Das',TO_DATE('05-01-24', 'YYYY-MM-DD'), 'Khulna,Bangladesh');
insert into Users(User_ID, Username, Email, Password, Name, DOB, Address) values(112, 'sumon', 'sumon@gmail.com', 4611, 'Sumon Das',TO_DATE('02-02-24', 'YYYY-MM-DD'), 'Dhaka,Bangladesh');
insert into Users(User_ID, Username, Email, Password, Name, DOB, Address) values(113, 'niloy', 'niloy@gmail.com', 4611, 'Niloy Das',TO_DATE('03-04-24', 'YYYY-MM-DD'), 'Satkhira,Bangladesh');
insert into Users(User_ID, Username, Email, Password, Name, DOB, Address) values(114, 'pranto', 'pranto@gmail.com', 4611, 'Pranto Das',TO_DATE('06-07-24', 'YYYY-MM-DD'), 'Kapilmuni,Bangladesh');
insert into Users(User_ID, Username, Email, Password, Name, DOB, Address) values(115, 'anik', 'anik@gmail.com', 4611, 'Anik Das',TO_DATE('09-09-24', 'YYYY-MM-DD'), 'Jashore,Bangladesh');

insert into Accounts(Account_ID, User_ID, Account_Type, Balance) values(01, 111, 'Savings', 10500); 
insert into Accounts(Account_ID, User_ID, Account_Type, Balance) values(02, 112, 'Current', 9500); 
insert into Accounts(Account_ID, User_ID, Account_Type, Balance) values(03, 111, 'Debit Card', 10700); 
insert into Accounts(Account_ID, User_ID, Account_Type, Balance) values(04, 113, 'Credit Card', 12200); 
insert into Accounts(Account_ID, User_ID, Account_Type, Balance) values(05, 113, 'DPS Account', 10300); 

insert into Transactions(Transaction_ID, Account_ID, Tx_Date, Amount, Category, Description) values(11, 04, TO_DATE('01-01-24', 'YYYY-MM-DD'), 500, 'Salary', 'Salary Transcation Occured');
insert into Transactions(Transaction_ID, Account_ID, Tx_Date, Amount, Category, Description) values(12, 04, TO_DATE('02-06-24', 'YYYY-MM-DD'), 200, 'Rent', 'RentTranscation Occured');
insert into Transactions(Transaction_ID, Account_ID, Tx_Date, Amount, Category, Description) values(13, 05, TO_DATE('03-05-24', 'YYYY-MM-DD'), 300, 'Food', 'Food Transcation Occured');
insert into Transactions(Transaction_ID, Account_ID, Tx_Date, Amount, Category, Description) values(14, 05, TO_DATE('04-03-24', 'YYYY-MM-DD'), 500, 'Transport', 'Transport Transcation Occured');
insert into Transactions(Transaction_ID, Account_ID, Tx_Date, Amount, Category, Description) values(15, 05, TO_DATE('05-02-24', 'YYYY-MM-DD'), 700, 'Investment', 'Investment Transcation Occured'); 

INSERT INTO Categories(Category_ID, Name, Type) VALUES(1, 'Salary', 'Income');
INSERT INTO Categories(Category_ID, Name, Type) VALUES(2, 'Rent', 'Expense');
INSERT INTO Categories(Category_ID, Name, Type) VALUES(3, 'Food', 'Expense');
INSERT INTO Categories(Category_ID, Name, Type) VALUES(4, 'Transport', 'Expense');
INSERT INTO Categories(Category_ID, Name, Type) VALUES(5, 'Investment', 'Expense');

INSERT INTO Budgets(Budget_ID, User_ID, Category_ID, Amount, Period, StartDate, EndDate) VALUES(1, 114, 1, 1500.00, 'Monthly', TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'));
INSERT INTO Budgets(Budget_ID, User_ID, Category_ID, Amount, Period, StartDate, EndDate) VALUES(2, 114, 2, 600.00, 'Monthly', TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-31', 'YYYY-MM-DD'));
INSERT INTO Budgets(Budget_ID, User_ID, Category_ID, Amount, Period, StartDate, EndDate) VALUES(3, 115, 3, 700.00, 'Monthly', TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'));
INSERT INTO Budgets(Budget_ID, User_ID, Category_ID, Amount, Period, StartDate, EndDate) VALUES(4, 115, 4, 400.00, 'Monthly', TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'));
INSERT INTO Budgets(Budget_ID, User_ID, Category_ID, Amount, Period, StartDate, EndDate) VALUES(5, 111, 5, 1200.00, 'Monthly', TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'));

INSERT INTO Goals(Goal_ID, User_ID, Target_Amount, Current_Amount, Deadline, Goal_Type) VALUES (1, 111, 5000.00, 2500.00, TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'Savings');
INSERT INTO Goals(Goal_ID, User_ID, Target_Amount, Current_Amount, Deadline, Goal_Type) VALUES (2, 112, 10000.00, 7000.00, TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'Investment');
INSERT INTO Goals(Goal_ID, User_ID, Target_Amount, Current_Amount, Deadline, Goal_Type) VALUES (3, 113, 8000.00, 4000.00, TO_DATE('2025-06-30', 'YYYY-MM-DD'), 'Education');
INSERT INTO Goals(Goal_ID, User_ID, Target_Amount, Current_Amount, Deadline, Goal_Type) VALUES (4, 114, 12000.00, 8000.00, TO_DATE('2024-08-31', 'YYYY-MM-DD'), 'Travel');
INSERT INTO Goals(Goal_ID, User_ID, Target_Amount, Current_Amount, Deadline, Goal_Type) VALUES (5, 115, 15000.00, 12000.00, TO_DATE('2024-10-31', 'YYYY-MM-DD'), 'Emergency Fund');


```
 
# Let's Start The Project 

<div style="text-align:center">
 <b> Schema Diagram</b>
<img src="https://github.com/plabandas/Database_Project/assets/72873595/c361ed98-6144-4ec2-94a5-25fbe5500284"> 
</div>


## Creation Users Table.
 
 
> First, we create the table "Users". Here, we can see that the primary key is "UserID"  because it uniquely identifies each row in the table.
```
CREATE TABLE Users (
  User_ID INTEGER PRIMARY KEY,
  Username VARCHAR2(255) NOT NULL,
  Email VARCHAR2(255) NOT NULL,
  Password VARCHAR2(255) NOT NULL,
  Name VARCHAR2(255),  
  DOB DATE,  -- Added missing comma here
  Address CLOB  -- Corrected data type 
);

``` 


## Creation Accounts Table.
  
```
CREATE TABLE Accounts (
  Account_ID INTEGER PRIMARY KEY,
  User_ID INTEGER,
  Account_Type VARCHAR2(50) NOT NULL,
  Balance DECIMAL(15, 2) DEFAULT 0.00,
  FOREIGN KEY(User_ID) references Users(User_ID)
);

```




## Creation Transactions Table.
  
```
CREATE TABLE Transactions (
    Transaction_ID INTEGER PRIMARY KEY,
    Account_ID INTEGER ,
    Tx_Date DATE NOT NULL,
    Amount DECIMAL(15, 2) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Description VARCHAR(200),
    FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);

```




## Creation Categories Table.
  
```
CREATE TABLE Categories (
    Category_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Type VARCHAR(20) NOT NULL CHECK (Type IN ('Income', 'Expense', 'Transfer'))
);

```




## Creation Budgets Table.
 
 
```
CREATE TABLE Budgets (
    Budget_ID INTEGER PRIMARY KEY,
    User_ID INTEGER,
    Category_ID INTEGER,
    Amount DECIMAL(15, 2) NOT NULL,
    Period VARCHAR(20) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID)
);

```




## Creation Goals Table.
 
```
CREATE TABLE Goals (
    Goal_ID INTEGER PRIMARY KEY,
    User_ID INTEGER,
    Target_Amount DECIMAL(15, 2) NOT NULL,
    Current_Amount DECIMAL(15, 2) DEFAULT 0.00,
    Deadline DATE,
    Goal_Type VARCHAR(50) NOT NULL,  
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

``` 


## Data Insertion Into Database
#### Data Insertion Into Users Table: 
```
insert into Users(User_ID, Username, Email, Password, Name, DOB, Address) values(111, 'plaban', 'plaban@gmail.com', 4611, 'Plaban Das',TO_DATE('05-01-24', 'YYYY-MM-DD'), 'Khulna,Bangladesh');
insert into Users(User_ID, Username, Email, Password, Name, DOB, Address) values(112, 'sumon', 'sumon@gmail.com', 4611, 'Sumon Das',TO_DATE('02-02-24', 'YYYY-MM-DD'), 'Dhaka,Bangladesh');
insert into Users(User_ID, Username, Email, Password, Name, DOB, Address) values(113, 'niloy', 'niloy@gmail.com', 4611, 'Niloy Das',TO_DATE('03-04-24', 'YYYY-MM-DD'), 'Satkhira,Bangladesh');
insert into Users(User_ID, Username, Email, Password, Name, DOB, Address) values(114, 'pranto', 'pranto@gmail.com', 4611, 'Pranto Das',TO_DATE('06-07-24', 'YYYY-MM-DD'), 'Kapilmuni,Bangladesh');
insert into Users(User_ID, Username, Email, Password, Name, DOB, Address) values(115, 'anik', 'anik@gmail.com', 4611, 'Anik Das',TO_DATE('09-09-24', 'YYYY-MM-DD'), 'Jashore,Bangladesh');

```
#### Data Insertion Into Accounts Table: 
```
insert into Accounts(Account_ID, User_ID, Account_Type, Balance) values(01, 111, 'Savings', 10500); 
insert into Accounts(Account_ID, User_ID, Account_Type, Balance) values(02, 112, 'Current', 9500); 
insert into Accounts(Account_ID, User_ID, Account_Type, Balance) values(03, 111, 'Debit Card', 10700); 
insert into Accounts(Account_ID, User_ID, Account_Type, Balance) values(04, 113, 'Credit Card', 12200); 
insert into Accounts(Account_ID, User_ID, Account_Type, Balance) values(05, 113, 'DPS Account', 10300); 

```

#### Data Insertion Into Transactions Table: 
```
insert into Transactions(Transaction_ID, Account_ID, Tx_Date, Amount, Category, Description) values(11, 04, TO_DATE('01-01-24', 'YYYY-MM-DD'), 500, 'Salary', 'Salary Transcation Occured');
insert into Transactions(Transaction_ID, Account_ID, Tx_Date, Amount, Category, Description) values(12, 04, TO_DATE('02-06-24', 'YYYY-MM-DD'), 200, 'Rent', 'RentTranscation Occured');
insert into Transactions(Transaction_ID, Account_ID, Tx_Date, Amount, Category, Description) values(13, 05, TO_DATE('03-05-24', 'YYYY-MM-DD'), 300, 'Food', 'Food Transcation Occured');
insert into Transactions(Transaction_ID, Account_ID, Tx_Date, Amount, Category, Description) values(14, 05, TO_DATE('04-03-24', 'YYYY-MM-DD'), 500, 'Transport', 'Transport Transcation Occured');
insert into Transactions(Transaction_ID, Account_ID, Tx_Date, Amount, Category, Description) values(15, 05, TO_DATE('05-02-24', 'YYYY-MM-DD'), 700, 'Investment', 'Investment Transcation Occured'); 

```


#### Data Insertion Into Category Table: 
```
INSERT INTO Categories(Category_ID, Name, Type) VALUES(1, 'Salary', 'Income');
INSERT INTO Categories(Category_ID, Name, Type) VALUES(2, 'Rent', 'Expense');
INSERT INTO Categories(Category_ID, Name, Type) VALUES(3, 'Food', 'Expense');
INSERT INTO Categories(Category_ID, Name, Type) VALUES(4, 'Transport', 'Expense');
INSERT INTO Categories(Category_ID, Name, Type) VALUES(5, 'Investment', 'Expense');

```


#### Data Insertion Into Budgets Table: 
```
INSERT INTO Budgets(Budget_ID, User_ID, Category_ID, Amount, Period, StartDate, EndDate) VALUES(1, 114, 1, 1500.00, 'Monthly', TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'));
INSERT INTO Budgets(Budget_ID, User_ID, Category_ID, Amount, Period, StartDate, EndDate) VALUES(2, 114, 2, 600.00, 'Monthly', TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-31', 'YYYY-MM-DD'));
INSERT INTO Budgets(Budget_ID, User_ID, Category_ID, Amount, Period, StartDate, EndDate) VALUES(3, 115, 3, 700.00, 'Monthly', TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'));
INSERT INTO Budgets(Budget_ID, User_ID, Category_ID, Amount, Period, StartDate, EndDate) VALUES(4, 115, 4, 400.00, 'Monthly', TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'));
INSERT INTO Budgets(Budget_ID, User_ID, Category_ID, Amount, Period, StartDate, EndDate) VALUES(5, 111, 5, 1200.00, 'Monthly', TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'));

```



#### Data Insertion Into Goal Table: 
```
INSERT INTO Goals(Goal_ID, User_ID, Target_Amount, Current_Amount, Deadline, Goal_Type) VALUES (1, 111, 5000.00, 2500.00, TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'Savings');
INSERT INTO Goals(Goal_ID, User_ID, Target_Amount, Current_Amount, Deadline, Goal_Type) VALUES (2, 112, 10000.00, 7000.00, TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'Investment');
INSERT INTO Goals(Goal_ID, User_ID, Target_Amount, Current_Amount, Deadline, Goal_Type) VALUES (3, 113, 8000.00, 4000.00, TO_DATE('2025-06-30', 'YYYY-MM-DD'), 'Education');
INSERT INTO Goals(Goal_ID, User_ID, Target_Amount, Current_Amount, Deadline, Goal_Type) VALUES (4, 114, 12000.00, 8000.00, TO_DATE('2024-08-31', 'YYYY-MM-DD'), 'Travel');
INSERT INTO Goals(Goal_ID, User_ID, Target_Amount, Current_Amount, Deadline, Goal_Type) VALUES (5, 115, 15000.00, 12000.00, TO_DATE('2024-10-31', 'YYYY-MM-DD'), 'Emergency Fund');

```

<p align="center"><span style="color: #FF0000; background-color: #ADD8E6; padding: 5px; border-radius: 5px;">Designed By Plaban Das</span></p>

