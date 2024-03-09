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

# Let's Start PL/SQL

## Showing Users Table's One Record
```
SET SERVEROUTPUT ON;

DECLARE
    v_user_id Users.User_ID%TYPE;
    v_username Users.Username%TYPE;
    v_email Users.Email%TYPE;
    v_password Users.Password%TYPE;
    v_name Users.Name%TYPE;
    v_dob Users.DOB%TYPE;
    v_address Users.Address%TYPE;
BEGIN
        select user_id, username, email, password, name, dob, address 
        into v_user_id, v_username, v_email, v_password, v_name, v_dob, v_address  from Users
        where user_id = 111;
        
        -- Display user data
        DBMS_OUTPUT.PUT_LINE('User ID: ' || v_user_id);
        DBMS_OUTPUT.PUT_LINE('Username: ' || v_username);
        DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
        DBMS_OUTPUT.PUT_LINE('Password: ' || v_password);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
        DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || TO_CHAR(v_dob, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('Address: ' || v_address);
        DBMS_OUTPUT.PUT_LINE('-------------------End OF One Record By Plaban----------------------');
    END LOOP;
END;
/ 
```

## Showing Users Table All Records Using Cursor And Row Type
```
SET SERVEROUTPUT ON;

DECLARE 
    v_user Users%ROWTYPE; -- Declare a variable of the user row type 
    CURSOR user_cursor IS SELECT * FROM Users; -- Cursor to fetch data from the Users table
BEGIN 
    OPEN user_cursor; -- Open the cursor 
    
    LOOP 
        FETCH user_cursor INTO v_user; -- Fetch and display user data 
        EXIT WHEN user_cursor%NOTFOUND; --Termination Criteria
        
        -- Display user data
        DBMS_OUTPUT.PUT_LINE('User ID: ' || v_user.User_ID); DBMS_OUTPUT.PUT_LINE('Username: ' || v_user.Username); DBMS_OUTPUT.PUT_LINE('Email: ' || v_user.Email); DBMS_OUTPUT.PUT_LINE('Password: ' || v_user.Password); DBMS_OUTPUT.PUT_LINE('Name: ' || v_user.Name); DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || TO_CHAR(v_user.DOB, 'YYYY-MM-DD')); DBMS_OUTPUT.PUT_LINE('Address: ' || v_user.Address);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
    END LOOP;
 
    CLOSE user_cursor; -- Close the cursor
END;
/

```

## Insertion Into Users Table Using PL/SQL
```
DECLARE 
    v_user Users%ROWTYPE; -- Declare a variable of the user row type
BEGIN
    -- Assign values to the v_user variable
    v_user.User_ID := 123; -- Example User_ID
    v_user.Username := 'example_user';
    v_user.Email := 'example@example.com';
    v_user.Password := 'example_password';
    v_user.Name := 'Example User';
    v_user.DOB := TO_DATE('1990-01-01', 'YYYY-MM-DD');
    v_user.Address := '123 Example St, Example City';

    -- Insert the data into the Users table
    INSERT INTO Users VALUES v_user;

    -- Commit the transaction
    COMMIT;
END;
/

```

#### Natural Join Or Join Table: 
```
select * from Users inner join Accounts on Users.USER_ID = Accounts.USER_ID;
```

#### Left Join Or Left Outer Join Table: 
```
select * from Users left Join Accounts on Users.USER_ID = Accounts.USER_ID;
```

#### Right Join Or Right Outer Join Table: 
```
select * from Users right Join Accounts on Users.USER_ID = Accounts.USER_ID;
```

## <p style="color: #FF0000; background-color: #ADD8E6; width: 100%; height: 45px; text-align: center; line-height: 40px;">Designed By Plaban Das</p>