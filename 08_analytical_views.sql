-- | View                     | Purpose             |
-- | ------------------------ | ------------------- |
-- | `vw_transaction_summary` | Overall KPIs        |
-- | `vw_monthly_trends`      | Time trends         |
-- | `vw_customer_metrics`    | Customer dashboard  |
-- | `vw_merchant_metrics`    | Merchant dashboard  |
-- | `vw_payment_failure`     | Payment performance |
-- | `vw_customer_activity`   | Retention/cohort    |


-- ====================================================
-- View 1 — Transaction Summary
-- ====================================================

CREATE VIEW vw_transaction_summary AS
SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE
        WHEN transaction_status = 'Success' THEN amount
        ELSE 0
    END) AS successful_gmv,
    AVG(amount) AS avg_transaction_value,
    SUM(CASE
        WHEN transaction_status = 'Success' THEN 1
        ELSE 0
    END) AS successful_transactions,
    SUM(CASE
        WHEN transaction_status = 'Failed' THEN 1
        ELSE 0
    END) AS failed_transactions,
    ROUND(
        100.0 * SUM(
            CASE WHEN transaction_status = 'Success' THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS success_rate
FROM transactions;


-- ====================================================
-- View 2 — Monthly Trends
-- ====================================================
CREATE VIEW vw_monthly_trends AS
SELECT
    DATE_FORMAT(transaction_datetime, '%Y-%m') AS month,
    COUNT(*) AS total_transactions,
    SUM(CASE
        WHEN transaction_status = 'Success' THEN amount
        ELSE 0
    END) AS successful_gmv,
    SUM(CASE
        WHEN transaction_status = 'Success' THEN 1
        ELSE 0
    END) AS successful_transactions,
    ROUND(
        100.0 * SUM(
            CASE WHEN transaction_status = 'Success' THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS success_rate
FROM transactions
GROUP BY DATE_FORMAT(transaction_datetime, '%Y-%m');

-- =========================================================
-- View 3 — Customer Metrics
-- =========================================================
CREATE VIEW vw_customer_metrics AS
SELECT
    c.customer_id,
    c.customer_segment,
    c.city,
    c.state,
    c.preferred_payment_method,

    COUNT(t.transaction_id) AS total_transactions,

    SUM(CASE
        WHEN t.transaction_status = 'Success' THEN t.amount
        ELSE 0
    END) AS total_spend,

    AVG(CASE
        WHEN t.transaction_status = 'Success' THEN t.amount
        ELSE NULL
    END) AS avg_transaction_value,

    SUM(CASE
        WHEN t.transaction_status = 'Success' THEN 1
        ELSE 0
    END) AS successful_transactions

FROM customers c
LEFT JOIN transactions t
    ON c.customer_id = t.customer_id

GROUP BY
    c.customer_id,
    c.customer_segment,
    c.city,
    c.state,
    c.preferred_payment_method;
    
-- ===============================================
-- View 4 — Merchant Metrics
-- ===============================================
CREATE VIEW vw_merchant_metrics AS
SELECT
    m.merchant_id,
    m.merchant_name,
    m.category,
    m.merchant_type,
    m.city,
    m.state,

    COUNT(t.transaction_id) AS total_transactions,

    SUM(CASE
        WHEN t.transaction_status = 'Success' THEN t.amount
        ELSE 0
    END) AS successful_gmv,

    SUM(CASE
        WHEN t.transaction_status = 'Success' THEN 1
        ELSE 0
    END) AS successful_transactions,

    ROUND(
        100.0 * SUM(
            CASE WHEN t.transaction_status = 'Success' THEN 1 ELSE 0 END
        ) / COUNT(t.transaction_id),
        2
    ) AS success_rate

FROM merchants m
LEFT JOIN transactions t
    ON m.merchant_id = t.merchant_id

GROUP BY
    m.merchant_id,
    m.merchant_name,
    m.category,
    m.merchant_type,
    m.city,
    m.state;
    

-- ===================================================
-- View 5 — Payment Failure Analysis
-- ===================================================
CREATE VIEW vw_payment_failure AS
SELECT
    t.payment_method,
    f.failure_reason,
    f.resolution_status,

    COUNT(*) AS failure_count,

    AVG(f.retry_attempt) AS avg_retry_attempts,

    SUM(t.amount) AS failed_transaction_value

FROM transaction_failures f
JOIN transactions t
    ON f.transaction_id = t.transaction_id

GROUP BY
    t.payment_method,
    f.failure_reason,
    f.resolution_status;


-- =================================================
-- View 6 — Customer Retention
-- =================================================
CREATE VIEW vw_customer_activity AS
SELECT
    customer_id,
    DATE_FORMAT(transaction_datetime, '%Y-%m') AS transaction_month,
    COUNT(*) AS transactions,
    SUM(
        CASE
            WHEN transaction_status = 'Success'
            THEN amount
            ELSE 0
        END
    ) AS successful_gmv
FROM transactions
GROUP BY
    customer_id,
    DATE_FORMAT(transaction_datetime, '%Y-%m');


-- ====================================================
-- View 7 — Potential Anomalies
-- ====================================================
CREATE VIEW vw_transaction_anomalies AS
SELECT
    transaction_id,
    customer_id,
    merchant_id,
    transaction_datetime,
    amount,
    payment_method,
    transaction_status
FROM transactions
WHERE amount > (
    SELECT AVG(amount) + 3 * STDDEV(amount)
    FROM transactions
);


