## For Deleting All The Tables Of A User
 
 
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


