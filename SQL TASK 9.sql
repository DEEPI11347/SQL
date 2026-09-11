use deepii_db;
CREATE TABLE transactions1 (
    transaction_id INT ,
    transaction_date DATE,
    department varchar(30),
    transaction_type varchar(30),
    amount DECIMAL(10,2)
);
INSERT INTO transactions1
(transaction_id,  transaction_date, department,transaction_type ,amount)
VALUES
(1,'2026-02-19',"Sales","income",56000),
(2,'2026-02-07',"HR","expense",16000),
(3,'2026-03-14',"sales","income",66000),
(4,'2026-03-24',"IT","expense",26000),
(5,'2026-04-02',"sales","income",65000),
(6,'2026-04-19',"HR","expense",10000),
(7,'2026-05-04',"sales","income",70000);SELECT * FROM transactions;

with monthly_summary as(
select year(transaction_date)as year,month(transaction_date)as month,sum(amount) as total_amount
from transactions1
group by year(transaction_date),month(transaction_date)
)
select*from monthly_summary; 

select year(transaction_date)as year,month(transaction_date)as month,sum(amount) as total_amount
from transactions1
where transaction_type="income"
group by year(transaction_date),month(transaction_date);


select year(transaction_date)as year,sum(amount) as total_income
from transactions1
where transaction_type="income"
group by year(transaction_date);  

select department,sum(amount) as total_expenses
from transactions1
where transaction_type="expense"
group by department;

select year(transaction_date)as year,department,sum(amount) as total_expenses
from transactions1
where transaction_type="expense"
group by year(transaction_date),department;
