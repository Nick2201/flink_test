/*
1. [ ]: Стремный счет
2. [ ]: Стремный трейдер
3. [ ]: Combo master
#1
- В окне 2 секунд > 10 траназкций
- Счет для перегонки денег

#2
- Трейдер не трейдер - это 5 индусов

*/

/**/
CREATE TABLE transactions_trader_location (
    event_id STRING,
    amount DOUBLE,
    `timestamp` TIMESTAMP(3),
    merchant STRING,
    location STRING,

    WATERMARK FOR `timestamp` AS `timestamp` - INTERVAL '5' SECOND
) WITH (
    'connector' = 'faker',
    'rows-per-second' = '10',

    'fields.account_id.expression' = '#{Options.option ''account_a'',''account_b'',''account_c'',''account_d'',''account_e''}',
    'fields.amount.expression' = '#{number.randomDouble ''2'',''50'',''5000''}',
    'fields.timestamp.expression' = '#{date.past ''15'',''SECONDS''}',
    'fields.merchant.expression' = '#{Options.option ''Amazon'',''Walmart'',''Target'',''BestBuy'',''AppleStore''}',
    'fields.location.expression' = '#{Options.option ''New York'',''Los Angeles'',''Chicago'',''Houston'',''Miami''}'
);

CREATE TABLE transactions (
    account_id STRING,
    transaction_id STRING,
    account_id STRING,
    amount DOUBLE,
    operation_type VARCHAR(1)
    event_time TIMESTAMP(3),
    merchant STRING,
    WATERMARK FOR event_time AS event_time - INTERVAL '2' SECOND
) WITH (
    'connector' = 'faker',
    'rows-per-second' = '100',
        'fields.transaction_id.expression' = '#{Internet.uuid}',
    'fields.account_id.expression' = '#{Options.option ''account_a'',''account_b'',''account_c'',''account_d'',''account_e''}',
    'fields.amount.expression' = '#{number.randomDouble ''2'',''100'',''5000''}',
    'fields.operation_type.expression' = '#{Options.option ''+'',''-''}',
    'fields.merchant.expression' = '#{Options.option ''Amazon'',''Walmart'',''Target'',''BestBuy'',''AppleStore''}',
    'fields.event_time.expression' = '#{date.past ''15'',''SECONDS''}'
);


$PATH java=/opt/flink/lib/