/*
Q.3 Have you previously worked with Apache Flink? If so, can you provide some examples of projects where you have used it?
*/
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