-- USE digital_payment;

SELECT * FROM customers;

-- Number of transactions per customer
SELECT
    customer_id,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_spend
FROM transactions
GROUP BY customer_id
ORDER BY total_spend DESC;

-- Top 10 customers by spending
SELECT
    customer_id,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_spend
FROM transactions
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 10;

-- Customer segment analysis
-- How does customer behavior differ across different customer segments in terms of number of customers, transaction volume, and total GMV from successful transactions?
SELECT
    c.customer_segment,
    COUNT(DISTINCT c.customer_id) AS customers,
    COUNT(t.transaction_id) AS transactions,
    SUM(CASE
        WHEN t.transaction_status = 'Success' THEN t.amount
        ELSE 0
    END) AS gmv
FROM customers c
LEFT JOIN transactions t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_segment
ORDER BY gmv DESC;


