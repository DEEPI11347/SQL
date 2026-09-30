CREATE DATABASE FinancialDBd;
USE FinancialDBd;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(200)
);
CREATE TABLE Account (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    balance DECIMAL(12,2) DEFAULT 0.00,
    opening_date DATE,
    status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
);
CREATE TABLE FinancialTransaction (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    description VARCHAR(200),

    FOREIGN KEY (account_id)
        REFERENCES Account(account_id)
);
CREATE TABLE Invoice (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    invoice_date DATE NOT NULL,
    due_date DATE NOT NULL,
    invoice_amount DECIMAL(12,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
);
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(30),

    FOREIGN KEY (invoice_id)
        REFERENCES Invoice(invoice_id)
);
INSERT INTO Customer
(customer_name, email, phone, address)
VALUES
('Deepika', 'deepika@gmail.com', '9876543210', 'Mangalore'),
('Ananya', 'ananya@gmail.com', '9876543211', 'Bangalore'),
('Rahul', 'rahul@gmail.com', '9876543212', 'Mysore'),
('Arjun', 'arjun@gmail.com', '9876543213', 'Udupi'),
('Sneha', 'sneha@gmail.com', '9876543214', 'Hubli');

INSERT INTO Account
(customer_id, account_type, balance, opening_date)
VALUES
(1, 'Savings', 25000.00, '2026-01-10'),
(2, 'Savings', 30000.00, '2026-01-15'),
(3, 'Current', 45000.00, '2026-02-01'),
(4, 'Savings', 18000.00, '2026-02-10'),
(5, 'Current', 50000.00, '2026-03-01');

INSERT INTO FinancialTransaction
(account_id, transaction_date, transaction_type, amount, description)
VALUES
(1, '2026-04-01', 'Credit', 10000, 'Salary'),
(1, '2026-04-05', 'Debit', 2500, 'Shopping'),
(2, '2026-04-03', 'Credit', 15000, 'Salary'),
(2, '2026-04-10', 'Debit', 3000, 'Bills'),
(3, '2026-04-02', 'Credit', 20000, 'Business Income'),
(3, '2026-04-08', 'Debit', 5000, 'Office Expense'),
(4, '2026-04-04', 'Credit', 8000, 'Salary'),
(5, '2026-04-06', 'Debit', 7000, 'Purchase');

INSERT INTO Invoice
(customer_id, invoice_date, due_date, invoice_amount, status)
VALUES
(1, '2026-04-01', '2026-04-15', 10000, 'Paid'),
(2, '2026-04-03', '2026-04-18', 15000, 'Pending'),
(3, '2026-04-05', '2026-04-20', 20000, 'Paid'),
(4, '2026-04-07', '2026-04-22', 8000, 'Pending'),
(5, '2026-04-10', '2026-04-25', 12000, 'Paid');

INSERT INTO Payment
(invoice_id, payment_date, payment_amount, payment_method)
VALUES
(1, '2026-04-10', 10000, 'UPI'),
(3, '2026-04-15', 20000, 'Bank Transfer'),
(5, '2026-04-20', 12000, 'Cash');

SELECT * FROM Customer;
SELECT * FROM Account;

SELECT *
FROM Customer
WHERE address = 'Mangalore';

SELECT
    c.customer_id,
    c.customer_name,
    a.account_id,
    a.account_type,
    a.balance
FROM Customer c
JOIN Account a
ON c.customer_id = a.customer_id;

SELECT
    c.customer_name,
    t.transaction_date,
    t.transaction_type,
    t.amount,
    t.description
FROM Customer c
JOIN Account a
ON c.customer_id = a.customer_id
JOIN FinancialTransaction t
ON a.account_id = t.account_id;

SELECT
    c.customer_name,
    i.invoice_id,
    i.invoice_date,
    i.due_date,
    i.invoice_amount,
    i.status
FROM Customer c
JOIN Invoice i
ON c.customer_id = i.customer_id;

SELECT
    account_type,
    SUM(balance) AS total_balance
FROM Account
GROUP BY account_type;

SELECT
    transaction_type,
    SUM(amount) AS total_amount
FROM FinancialTransaction
GROUP BY transaction_type;

SELECT
    address,
    COUNT(*) AS customer_count
FROM Customer
GROUP BY address;

SELECT customer_name
FROM Customer
WHERE customer_id IN
(
    SELECT customer_id
    FROM Account
    WHERE balance >
    (
        SELECT AVG(balance)
        FROM Account
    )
);

SELECT *
FROM Account
WHERE balance =
(
    SELECT MAX(balance)
    FROM Account
);
WITH CustomerBalance AS
(
    SELECT
        customer_id,
        SUM(balance) AS total_balance
    FROM Account
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    cb.total_balance
FROM Customer c
JOIN CustomerBalance cb
ON c.customer_id = cb.customer_id;

SELECT
    c.customer_name,
    a.balance,
    RANK() OVER (ORDER BY a.balance DESC) AS balance_rank
FROM Customer c
JOIN Account a
ON c.customer_id = a.customer_id;

SELECT
    transaction_id,
    transaction_date,
    amount,
    SUM(amount) OVER
    (
        ORDER BY transaction_date
    ) AS running_total
FROM FinancialTransaction;

CREATE VIEW CustomerAccountView AS
SELECT
    c.customer_id,
    c.customer_name,
    c.email,
    a.account_id,
    a.account_type,
    a.balance
FROM Customer c
JOIN Account a
ON c.customer_id = a.customer_id;

SELECT *
FROM CustomerAccountView;

CREATE VIEW FinancialReport AS
SELECT
    t.transaction_type,
    COUNT(*) AS transaction_count,
    SUM(t.amount) AS total_amount,
    AVG(t.amount) AS average_amount
FROM FinancialTransaction t
GROUP BY t.transaction_type;

SELECT *
FROM FinancialReport;

DELIMITER //

CREATE PROCEDURE GetCustomerAccounts(IN cust_id INT)
BEGIN
    SELECT
        c.customer_name,
        a.account_id,
        a.account_type,
        a.balance
    FROM Customer c
    JOIN Account a
    ON c.customer_id = a.customer_id
    WHERE c.customer_id = cust_id;
END //

DELIMITER ;

CALL GetCustomerAccounts(1);

DELIMITER //

CREATE PROCEDURE DepositMoney(
    IN acc_id INT,
    IN deposit_amount DECIMAL(12,2)
)
BEGIN

    UPDATE Account
    SET balance = balance + deposit_amount
    WHERE account_id = acc_id;

    INSERT INTO FinancialTransaction
    (account_id, transaction_date, transaction_type, amount, description)
    VALUES
    (acc_id, CURDATE(), 'Credit', deposit_amount, 'Deposit');

END //

DELIMITER ;

CALL DepositMoney(1, 5000);
SELECT *
FROM Account
WHERE account_id = 1;

DELIMITER //

CREATE TRIGGER UpdateBalanceAfterTransaction
AFTER INSERT ON FinancialTransaction
FOR EACH ROW
BEGIN

    IF NEW.transaction_type = 'Credit' THEN

        UPDATE Account
        SET balance = balance + NEW.amount
        WHERE account_id = NEW.account_id;

    ELSEIF NEW.transaction_type = 'Debit' THEN

        UPDATE Account
        SET balance = balance - NEW.amount
        WHERE account_id = NEW.account_id;

    END IF;

END //

DELIMITER ;

INSERT INTO FinancialTransaction
(account_id, transaction_date, transaction_type, amount, description)
VALUES
(1, CURDATE(), 'Credit', 2000, 'Bonus');

SELECT *
FROM Account
WHERE account_id = 1;

DELIMITER //

CREATE TRIGGER PreventNegativeBalance
BEFORE INSERT ON FinancialTransaction
FOR EACH ROW
BEGIN

    IF NEW.transaction_type = 'Debit'
       AND NEW.amount >
       (SELECT balance
        FROM Account
        WHERE account_id = NEW.account_id)
    THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient account balance';

    END IF;

END //

DELIMITER ;

SELECT
    SUM(CASE
        WHEN transaction_type = 'Credit'
        THEN amount
        ELSE 0
    END) AS Total_Credit,

    SUM(CASE
        WHEN transaction_type = 'Debit'
        THEN amount
        ELSE 0
    END) AS Total_Debit
FROM FinancialTransaction;

SELECT
    c.customer_name,
    SUM(
        CASE
            WHEN t.transaction_type = 'Credit'
            THEN t.amount
            ELSE 0
        END
    ) AS total_credit,

    SUM(
        CASE
            WHEN t.transaction_type = 'Debit'
            THEN t.amount
            ELSE 0
        END
    ) AS total_debit

FROM Customer c
JOIN Account a
ON c.customer_id = a.customer_id

JOIN FinancialTransaction t
ON a.account_id = t.account_id

GROUP BY c.customer_id, c.customer_name;

SELECT
    c.customer_name,
    i.invoice_id,
    i.invoice_amount,
    i.due_date,
    i.status
FROM Customer c
JOIN Invoice i
ON c.customer_id = i.customer_id
WHERE i.status = 'Pending';

SELECT
    c.customer_name,
    i.invoice_id,
    i.invoice_amount,
    i.due_date
FROM Customer c
JOIN Invoice i
ON c.customer_id = i.customer_id
WHERE i.due_date < CURDATE()
AND i.status <> 'Paid';

CREATE USER 'finance_user'@'localhost'
IDENTIFIED BY 'Finance@123';

GRANT SELECT, INSERT, UPDATE
ON FinancialDB.*
TO 'finance_user'@'localhost';

SHOW GRANTS FOR 'finance_user'@'localhost';
