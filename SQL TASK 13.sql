create database transactions1;
use transactions1;
CREATE TABLE Customers (
    Customer_ID int primary key,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE transactions (
    transactions_id INT PRIMARY KEY,
    customer_id int,
    amount decimal(10,2),
    transactiondate date,
    foreign key(customer_id) references customers(customer_id)
);
CREATE TABLE Salalaris (
    Employee_ID int primary key,
    Employee_name VARCHAR(100),
    salary DECIMAL(10,2)
);

CREATE USER 'manager'@'localhost' IDENTIFIED BY 'Manager@123';

CREATE USER 'accountant'@'localhost' IDENTIFIED BY 'Account@123';

CREATE USER 'clerk'@'localhost' IDENTIFIED BY 'clerk@123';

grant select on transactions1.*
to'manager'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON transactions1.transactions
TO 'accountant'@'localhost';

grant select
on transactions1.Customers
to 'clerk'@'localhost';

grant delete
on transactions1.transactions
to 'accountant'@'localhost';

grant delete
on transactions1.Customers
to 'clerk'@'localhost';

revoke delete
on transactions1.transactions
from 'accountant'@'localhost';

show grants for "manager"@"localhost";
show grants for "accountant"@"localhost";
show grants for "clerk"@"localhost";