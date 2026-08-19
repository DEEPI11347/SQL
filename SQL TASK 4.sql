use deepika;
CREATE TABLE financial_transaction (
    transaction_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    invoice_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_date DATE,
    region VARCHAR(30)
);
INSERT INTO financial_transaction
(transaction_id, customer_name, invoice_amount, payment_status, payment_date, region)
VALUES
(1, 'Anil Kumar', 12500, 'Paid', '2026-01-05', 'South'),
(2, 'Priya Nair', 18500, 'Pending', '2026-01-08', 'South'),
(3, 'Rahul Sharma', 22000, 'Paid', '2026-01-10', 'North'),
(4, 'Sneha Thomas', 9500, 'Paid', '2026-01-12', 'South'),
(5, 'Arjun Mehta', 32000, 'Pending', '2026-01-15', 'West'),
(6, 'Kavya Menon', 15000, 'Overdue', '2026-01-18', 'South'),
(7, 'Rohit Verma', 27500, 'Paid', '2026-01-20', 'North'),
(8, 'Neha Kapoor', 11000, 'Pending', '2026-01-22', 'North'),
(9, 'Amit Patel', 45000, 'Paid', '2026-01-25', 'West'),
(10, 'Divya Rao', 17500, 'Paid', '2026-01-28', 'South'),
(11, 'Sanjay Gupta', 25000, 'Overdue', '2026-02-02', 'North'),
(12, 'Meera Iyer', 13500, 'Paid', '2026-02-05', 'South'),
(13, 'Vikram Singh', 38000, 'Pending', '2026-02-08', 'North'),
(14, 'Pooja Shah', 21000, 'Paid', '2026-02-10', 'West'),
(15, 'Kiran Das', 8500, 'Pending', '2026-02-12', 'East'),
(16, 'Ramesh Kumar', 29500, 'Paid', '2026-02-15', 'South'),
(17, 'Asha Nair', 16000, 'Overdue', '2026-02-18', 'South'),
(18, 'Manish Joshi', 52000, 'Paid', '2026-02-20', 'West'),
(19, 'Lakshmi Rao', 19500, 'Pending', '2026-02-22', 'East'),
(20, 'Deepak Sharma', 27500, 'Paid', '2026-02-25', 'North'),
(21, 'Swathi Menon', 12000, 'Paid', '2026-02-28', 'South'),
(22, 'Naveen Patel', 34000, 'Overdue', '2026-03-03', 'West'),
(23, 'Reshma Thomas', 14500, 'Pending', '2026-03-05', 'South'),
(24, 'Ajay Verma', 41000, 'Paid', '2026-03-08', 'North'),
(25, 'Geetha Iyer', 23000, 'Pending', '2026-03-10', 'East');
select*from financial_transaction;
select*from financial_transaction where customer_name= "Priya Nair" ;
select*from financial_transaction where invoice_amount=18500;
select*from financial_transaction where invoice_amount= 12500;
select*from financial_transaction where payment_date=2026-01-12;
select*from financial_transaction where region="south";

select*from financial_transaction where invoice_amount between 12500 and 18500 ;
select*from financial_transaction where region between " south" and "North";
select*from financial_transaction where payment_date between 2026-01-10 and 2026-01-22;
select*from financial_transaction where invoice_amount between 11000 and 38000 ;
select*from financial_transaction where invoice_amount between 11000 and 38000 ;


select*from financial_transaction where invoice_amount in ('paid','pending');
select*from financial_transaction where invoice_amount in(11000 , 38000 );
select*from financial_transaction where invoice_amount in (38000 , 18500);
select*from financial_transaction where region in ('south','North'); 
select*from financial_transaction where customer_name in('rohit','priya' );

select*from financial_transaction where customer_name like '%a';
select*from financial_transaction where customer_name like '%s';
select*from financial_transaction where customer_name like '%a-';
select*from financial_transaction where customer_name like '_a%';
select*from financial_transaction where customer_name like '%a%';

select distinct region from financial_transaction;
select distinct region,payment_status from financial_transaction;
select count(distinct region)as total_status from financial_transaction;
select count(distinct region,payment_status)as total_status from financial_transaction;
select distinct payment_status from financial_transaction;

select* from financial_transaction order by invoice_amount;
select* from financial_transaction order by invoice_amount desc;