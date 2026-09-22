create database accountsdb;
use accountsdb;
CREATE TABLE monthly_finance (
    id INT PRIMARY KEY,
    customer_name VARCHAR(90),
    month_name VARCHAR(50),
    sales DECIMAL(10,2),
    expenses DECIMAL(10,2),
    tax_rate DECIMAL(5,2)
    );
    
INSERT INTO monthly_finance
VALUES
(1, 'Geetha', 'January', 55000, 30000, 10),
(2, 'Ashok', 'January', 65000, 45000, 10),
(3, 'Anu', 'January', 50000, 25000, 10),

(4, 'Geetha', 'February', 65000, 32000, 10),
(5, 'Ashok', 'February', 75000, 39000, 10),
(6, 'Anu', 'February', 55000, 27000, 10),

(7, 'Geetha', 'March', 65000, 34000, 10),
(8, 'Ashok', 'March', 75000, 49000, 10),
(9, 'Anu', 'March', 60000, 30000, 10);
select * from monthly_finance;

DELIMITER //
CREATE PROCEDURE CalculateTAX(
     IN P_sales DECIMAL(10,2),
     IN P_tax_rate DECIMAL(10,2)
     )
     
BEGIN 
    SELECT P_sales AS Sales,
    P_tax_rate AS tax_rate,
    P_sales*P_tax_rate/100 AS tax_amount;
END //
DELIMITER ;

CALL CalculateTAX(5000,10);
CALL CalculateTAX(50000,14);

CREATE TABLE month_end_closing(
month VARCHAR(90),
total_sales DECIMAL(10,2),
total_expense DECIMAL(10,2),
profit_loss DECIMAL(10,2)
);

DELIMITER // 
CREATE PROCEDURE month_end_closing(
IN P_month VARCHAR(20))
BEGIN
INSERT INTO month_end_closing(month,total_sales,total_expense,profit_loss)
select month_name,SUM(sales),SUM(expenses),SUM(sales)-SUM(expenses)
from monthly_finance
where month_name=P_month
group by month_name;

END //
DELIMITER ; 

CALL month_end_closing("January");
CALL month_end_closing("March");

select * from month_end_closing;

DELIMITER //
create procedure CustomerSummary(
	in p_customer varchar(50)
)
BEGIN
	SELECT
		customer_name,
		sum(sales) as total_sales,
		sum(expenses) as total_expenses,
		sum(sales)-sum(expenses) as total_profit
	from monthly_finance
    where customer_name-P_customer
    group by customer_name;
END //
DELIMITER ;
 
 call CustomerSummary("Ashok");
 call CustomerSummary("Anu");
 
 CREATE TABLE YearEndProfit(
       total_sales decimal(10,2),
       total_expenses decimal(10,2),
       total_profit decimal(10,2)
       );
 
 DELIMITER //
create procedure YearEndProfit()
BEGIN
	insert into year_end_profit
    (total_sales,total_expenses,total_profit)
	select SUM(sales),
           SUM(expenses),
           SUM(sales) - SUM(expenses)
FROM monthly_finance;

END //
DELIMITER ;

CALL YearEndProfit();
select*from YearEndProfit ;