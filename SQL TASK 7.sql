create database financel;
use financel;
create table customers (
    customer_id int primary key,
    customer_name varchar(30),
    phone_number bigint
);
insert into customers values
(1,"Anu",1233545663),
(2,"Divya",456123780),
(3,"Sandya",7894561230),
(4,"Manya",4567891230);
select * from customers ;

    
    CREATE TABLE Invoices (
    Invoice_ID INT PRIMARY KEY,
    customer_ID INT,
    Invoice_Date DATE,
    Invoice_Amount DECIMAL(10,2),
    FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID)
);
insert into invoices values
(501, 1,'2026-08-10', 5000),
(502, 2,'2026-08-15', 3000),
(503, 3,'2026-08-20', 7000),
(504, 4,'2026-08-25', 4000);
select * from invoices;

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    invoice_id INT,
    payment_amount DECIMAL(10,2),
	FOREIGN KEY (invoice_id) references Invoices(invoice_id));
INSERT INTO Payments (payment_id, invoice_id, payment_amount)
VALUES
(11, 501, 6541),
(12, 502, 3578),
(13, 503, 36974),
(14, 504, 57341);
SELECT * FROM Payments;

create view customer_balances as 
select c.customer_name,
	   i.invoice_amount,
       p.payment_amount,
       i.invoice_amount - p.payment_amount as balance 
from Customers c
join Invoices i on c.customer_id=i.customer_id
join Payments p on i.invoice_id = p.invoice_id;

select * from customer_balances;


create view customer_overdue as 
select c.customer_name,
       i.invoice_amount - p.payment_amount as overdue 
from Customers c
join Invoices i on c.customer_id=i.customer_id
join Payments p on i.invoice_id = p.invoice_id
where invoice_amount> payment_amount;

select * from customer_overdue;

create view customer_overdue_balance as 
select c.customer_name,
	   i.invoice_amount,
       p.payment_amount,
       i.invoice_amount - p.payment_amount as balance ,
       DATEDIFF(CURDATE(),i.invoice_date) as days_overdue
from Customers c
join Invoices i on c.customer_id=i.customer_id
join Payments p on i.invoice_id = p.invoice_id;
select * from customer_overdue_balance;