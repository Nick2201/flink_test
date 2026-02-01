/*
Q.3 Have you previously worked with Apache Flink? If so, can you provide some examples of projects where you have used it?
*/
Уникальные location для кждого merch
CREATE TEMPORARY TABLE transactions (
    accountId STRING,
    amount DOUBLE,
    event_time TIMESTAMP(3),
    WATERMARK FOR event_time AS event_time - INTERVAL '5' SECOND
) WITH (
    'connector' = 'faker',
    'rows-per-second' = '50',
    'fields.accountId.expression' = '#{Options.option ''account_001'',''account_002'',''account_003'',''account_004'',''account_005''}',
    'fields.amount.expression' = '#{number.randomDouble ''2'',''100'',''5000''}',
    'fields.event_time.expression' = '#{date.past ''15'',''SECONDS''}'
);

CREATE TEMPORARY TABLE suspicious_transactions (
    accountId STRING,
    total_amount DOUBLE,
    window_start TIMESTAMP(3),
    window_end TIMESTAMP(3)
) WITH ('connector' = 'print');

INSERT INTO suspicious_transactions
SELECT 
    accountId,
    SUM(amount) as total_amount,
    TUMBLE_START(event_time, INTERVAL '10' MINUTE),
    TUMBLE_END(event_time, INTERVAL '10' MINUTE)
FROM transactions
GROUP BY accountId, TUMBLE(event_time, INTERVAL '10' MINUTE)
HAVING SUM(amount) > 10000;


/*
5.
*/

CREATE TABLE transactions_trader_location (
    transaction_id STRING,
    account_id STRING,
    amount DOUBLE,
    `timestamp` TIMESTAMP(3),
    merchant STRING,
    location STRING,
    WATERMARK FOR `timestamp` AS `timestamp` - INTERVAL '5' SECOND
) WITH (
    'connector' = 'faker',
    'rows-per-second' = '10',
    'fields.transaction_id.expression' = '#{Internet.uuid}',
    'fields.account_id.expression' = '#{Options.option ''account_a'',''account_b'',''account_c'',''account_d'',''account_e''}',
    'fields.amount.expression' = '#{number.randomDouble ''2'',''50'',''5000''}',
    'fields.timestamp.expression' = '#{date.past ''15'',''SECONDS''}',
    'fields.merchant.expression' = '#{Options.option ''Amazon'',''Walmart'',''Target'',''BestBuy'',''AppleStore''}',
    'fields.location.expression' = '#{Options.option ''New York'',''Los Angeles'',''Chicago'',''Houston'',''Miami''}'
);

CREATE TABLE suspicious_transactions (
    account_id STRING,
    window_start TIMESTAMP(3),
    window_end TIMESTAMP(3),
    transaction_count BIGINT,
    total_amount DOUBLE,
    fraud_score DOUBLE,
    alert_level STRING
) WITH ('connector' = 'print');

INSERT INTO suspicious_transactions
SELECT 
    account_id,
    window_start,
    window_end,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    CASE 
        WHEN COUNT(*) > 10 AND SUM(amount) > 5000 THEN 0.95
        WHEN COUNT(*) > 5 AND SUM(amount) > 2000 THEN 0.75
        ELSE 0.25
    END AS fraud_score,
    CASE 
        WHEN COUNT(*) > 10 AND SUM(amount) > 5000 THEN 'HIGH'
        WHEN COUNT(*) > 5 AND SUM(amount) > 2000 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS alert_level
FROM TABLE(
    TUMBLE(TABLE transactions, DESCRIPTOR(`timestamp`), INTERVAL '10' MINUTES)
)
GROUP BY account_id, window_start, window_end
HAVING 
    COUNT(*) > 3 OR 
    SUM(amount) > 1000 OR 
    COUNT(DISTINCT merchant) > 5;