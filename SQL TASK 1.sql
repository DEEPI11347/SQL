CREATE DATABASE FinancialDB;
USE FinancialDB;
CREATE TABLE Customer (
	Customer_id INT PRIMARY KEY,
    Customer_name VARCHAR(50),
    Email VARCHAR(30),
    Phone VARCHAR(60)
);
CREATE TABLE Accounts (
   account_id INT PRIMARY KEY,
   customer_id INT,
   account_type VARCHAR(90),
   balance DECIMAL(40,80)
);
CREATE TABLE Ledgers (  
    ledger_id INT PRIMARY KEY,
    account_id INT,
    ledger_date DATE,
    description VARCHAR(100),
    debit DECIMAL(10,20),
    credit DECIMAL(30,60)
);
CREATE TABLE Transaction (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transection_date DATE,
    transection_type VARCHAR(50),
    amount DECIMAL(50,40)
);
CREATE TABLE Invoices (
   invoice_id INT PRIMARY KEY,
   customer_id INT,
   issue_date DATE,
   due_date DATE,
   amount DECIMAL(20,3),
   status VARCHAR(52)
);
CREATE TABLE Payments (
   pyment_id INT PRIMARY KEY,
   invoice_id INT ,
   payment_date DATE,
   amount DECIMAL(10,2),
   payment_method VARCHAR(50)
);
    