-- Top merchants by GMV
SELECT
    merchant_id,
    COUNT(*) AS transactions,
    SUM(amount) AS gmv
FROM transactions
WHERE transaction_status = 'Success'
GROUP BY merchant_id
ORDER BY gmv DESC
LIMIT 10;

-- GMV by merchant category
SELECT
    m.category,
    COUNT(t.transaction_id) AS transactions,
    SUM(CASE
        WHEN t.transaction_status = 'Success' THEN t.amount
        ELSE 0
    END) AS gmv
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY m.category
ORDER BY gmv DESC;



-- Merchant success rate
SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(100.0 * SUM(CASE WHEN t.transaction_status = 'Success' THEN 1 ELSE 0 END) / COUNT(t.transaction_id),2) AS success_rate
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY m.merchant_id, m.merchant_name
HAVING COUNT(t.transaction_id) >= 50
ORDER BY success_rate DESC;

