use deepika_db;
CREATE TABLE monthly_sales (
    sale_month DATE,
    customer_name VARCHAR(50),
    sales DECIMAL(12,2)
);

INSERT INTO monthly_sales (sale_month, customer_name, sales)
VALUES
('2023-01-01', 'Arun', 100000),
('2023-02-01', 'Bala', 120000),
('2023-03-01', 'Arun', 110000),
('2023-04-01', 'Divya', 150000),
('2023-05-01', 'Bala', 130000),
('2023-06-01', 'Arun', 140000),
('2023-07-01', 'Divya', 150000),
('2023-08-01', 'Bala', 160000),
('2023-09-01', 'Arun', 140000),
('2023-10-01', 'Divya', 180000),
('2023-11-01', 'Bala', 170000),
('2023-12-01', 'Arun', 160000),

('2024-01-01', 'Arun', 130000),
('2024-02-01', 'Bala', 150000),
('2024-03-01', 'Arun', 140000),
('2024-04-01', 'Divya', 170000),
('2024-05-01', 'Bala', 160000),
('2024-06-01', 'Arun', 155000),
('2024-07-01', 'Divya', 180000),
('2024-08-01', 'Bala', 175000),
('2024-09-01', 'Arun', 165000),
('2024-10-01', 'Divya', 190000),
('2024-11-01', 'Bala', 185000),
('2024-12-01', 'Arun', 175000);
select sale_month,customer_name,sales,
     rank()over(order by sales desc)as sales_rank
from monthly_sales;

select sale_month,customer_name,sales,
     DENSE_rank()over(order by sales desc)as sales_rank
from monthly_sales;

select sale_month,customer_name,sales,
     ROW_number()over(order by sales desc)as sales_rank
from monthly_sales;

select sale_month,customer_name,sales,
     LAG(sales)over(order by sale_month)as previous_monnth_sales
from monthly_sales;

select sale_month,customer_name,sales,
     LEAD(sales,12)over(order by sale_month)as previous_year_sales
from monthly_sales;

select sale_month,sales,sum(sales)over(order by sale_month)as running_total
from monthly_sales;


select sale_month,sales,LAG(sales,12)over(order by sale_month)as previous_year_sales,
((sales - LAG(sales,12) over (order by sale_month))/LAG(sales,12) over (order by sale_month))*100 as yoy_growth
from monthly_sales;

select sale_month,customer_name,sales,
     rank()over(order by sales desc)as sales_rank,
     DENSE_rank()over(order by sales desc)as sales_rank,
     ROW_number()over(order by sales desc)as sales_rank,
     LAG(sales)over(order by sale_month)as previous_monnth_sales,
     LEAD(sales,12)over(order by sale_month)as previous_year_sales
from monthly_sales;


SELECT * FROM monthly_sales;