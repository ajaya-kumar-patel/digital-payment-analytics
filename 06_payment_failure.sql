-- Failure reasons
SELECT failure_reason, COUNT(*) AS failure_count
FROM fail_transactions
GROUP BY failure_reason
ORDER BY failure_count DESC;

-- Failure reason + retry attempts
SELECT failure_reason, AVG(retry_attempt) AS avg_retry_attempts, COUNT(*) AS failures
FROM fail_transactions
GROUP BY failure_reason
ORDER BY failures DESC;

-- Payment method failure rate
SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(CASE
        WHEN transaction_status = 'Failed' THEN 1
        ELSE 0
    END) AS failed_transactions,
    ROUND(
        100.0 * SUM(CASE
            WHEN transaction_status = 'Failed' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS failure_rate
FROM transactions
GROUP BY payment_method
ORDER BY failure_rate DESC;