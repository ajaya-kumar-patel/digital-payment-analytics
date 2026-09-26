-- database init
-- USE digital_payment;

-- Show Table
-- SELECT * FROM transactions;

-- Total number of transactions
-- SELECT COUNT(*) FROM transactions;

-- Total transaction value / GMV
-- SELECT SUM(amount) total_gmv
-- FROM transactions;

-- Average transaction value
-- SELECT AVG(amount) AS avg_transaction_value
-- FROM transactions;

-- Successful vs failed transactions
-- SELECT transaction_status, COUNT(*) AS transaction_count
-- FROM transactions
-- GROUP BY transaction_status;


-- Success rate
-- SELECT AVG(transaction_status='Success')*100 AS success_rate
-- FROM transactions;

-- GMV by payment method
-- SELECT payment_method, 
-- COUNT(*) AS transaction_count,
-- SUM(amount) AS total_gmv,
-- ROUND(AVG(amount), 2) AS avg_transaction_value
-- FROM transactions
-- GROUP BY payment_method
-- ORDER BY transaction_count DESC;


-- Monthly transaction trend
-- SELECT DATE_FORMAT(transaction_datetime, '%Y-%m') AS month,
-- COUNT(*) AS total_transaction,
-- SUM(amount) AS gmv
-- FROM transactions
-- GROUP BY month 
-- ORDER BY month ASC;







