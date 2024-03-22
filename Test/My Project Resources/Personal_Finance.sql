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
 