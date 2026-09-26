WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spend
    FROM transactions
    WHERE transaction_status = 'Success'
    GROUP BY customer_id
)
SELECT *
FROM customer_spending
WHERE total_spend > 50000
ORDER BY total_spend DESC;

-- rank customers within each customer segment
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_segment,
        SUM(t.amount) AS total_spend
    FROM customers c
    JOIN transactions t
        ON c.customer_id = t.customer_id
    WHERE t.transaction_status = 'Success'
    GROUP BY c.customer_id, c.customer_segment
)
SELECT
    customer_id,
    customer_segment,
    total_spend,
    RANK() OVER (
        PARTITION BY customer_segment
        ORDER BY total_spend DESC
    ) AS spending_rank
FROM customer_spending;

-- Monthly GMV growth:
WITH monthly_gmv AS (
    SELECT
        DATE_FORMAT(transaction_datetime, '%Y-%m') AS month,
        SUM(amount) AS gmv
    FROM transactions
    WHERE transaction_status = 'Success'
    GROUP BY DATE_FORMAT(transaction_datetime, '%Y-%m')
)
SELECT
    month,
    gmv,
    LAG(gmv) OVER (ORDER BY month) AS previous_month_gmv
FROM monthly_gmv
ORDER BY month;

-- Customer Retention
SELECT customer_id, MIN(transaction_datetime) AS first_transaction_date
FROM transactions
WHERE transaction_status = 'Success'
GROUP BY customer_id;

