use deepu_db;

create table journal_entries(
entry_id int primary key,
entry_date date,
account_name varchar(100),
description varchar(90),
debit decimal(10,2),
credit decimal(10,2)
);
INSERT INTO journal_entries
(entry_id, entry_date, account_name, description, debit, credit)
VALUES
(1, '2026-01-01', 'Cash', 'Capital introduced', 50000, 0),

(2, '2026-01-01', 'Capital', 'Capital introduced', 0, 50000),

(3, '2026-01-03', 'Purchases', 'Goods purchased for cash', 20000, 0),

(4, '2026-01-03', 'Cash', 'Goods purchased for cash', 0, 20000),

(5, '2026-01-05', 'Rent', 'Rent paid in cash', 5000, 0),

(6, '2026-01-05', 'Cash', 'Rent paid in cash', 0, 5000),

(7, '2026-01-10', 'Cash', 'Goods sold for cash', 30000, 0),

(8, '2026-01-10', 'Sales', 'Goods sold for cash', 0, 30000),

(9, '2026-01-15', 'Furniture', 'Furniture purchased for cash', 10000, 0),

(10, '2026-01-15', 'Cash', 'Furniture purchased for cash', 0, 10000);
select*from journal_entries;
       
select 
       sum(debit) as total_debit,
       sum(credit) as total_crdit
from journal_entries;

select 
       avg(debit) as total_debit,
       avg(credit) as total_crdit
from journal_entries;

select 
       count(*) as total_debit,
       count(*) as total_crdit
from journal_entries;

select
       min(debit) as total_debit,
       min(credit) as total_crdit
from journal_entries;

select 
       max(debit) as total_debit,
       max(credit) as total_crdit
from journal_entries;

select account_name,
       count(*) as total
from journal_entries
group by account_name;

select account_name,
       avg(debit) as avreage_debit,
       avg(credit) as avreage_crdit
from journal_entries
group by account_name;

select account_name,
       sum(debit) as total_debit,
       sum(credit) as total_crdit
from journal_entries
group by account_name
HAVING SUM(debit)>15000;

select account_name,
       count(*) as total
from journal_entries
group by account_name
HAVING count(*)>1;

select account_name,
      case
      when sum(debit)>sum(credit)
      then sum(debit)-sum(credit)
	  else 0
    end as debit_balance,
      case
      when sum(credit)>sum(debit)
      then sum(credit)-sum(debit)
      else 0
	end as credit_balance
from journal_entries
group by account_name;


