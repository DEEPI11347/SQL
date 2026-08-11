use my_Financialdb;
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_name VARCHAR(32) NOT NULL,
    Email VARCHAR(50) UNIQUE,
    Phone VARCHAR(10)
);    
CREATE TABLE Accounts (
   Account_ID INT PRIMARY KEY,
   Customer_ID INT (25),
   Account_Type VARCHAR (20) NOT NULL,
   Balance DECIMAL (10,4),
   FOREIGN KEY (Customr_ID)
   REFERENCES Customers
);
CREATE TABLE Transections (
    Transection_ID INT PRIMARY KEY,
	Account_ID INT (60),
    Transection_Date DATE,
    Transection_Type VARCHAR (40) NOT NULL,
    Amount DECIMAL (90,60),
    FOREIGN KEY (Transection_ID)
    REFERENCES Transections
);
ALTER TABLE Customers ADD Address VARCHAR(70);
ALTER TABLE Acounts ADD CONSTRAINT CHECK(Amount>=0);
CREATE TABLE Test_Table(
    ID int
);
DROP TABLE Test_Table;