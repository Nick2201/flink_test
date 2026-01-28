-- 1. Bid
CREATE TABLE Bid (
    bidtime TIMESTAMP(3),
    price DECIMAL(10, 2),
    item STRING,
    bidder STRING,
    WATERMARK FOR bidtime AS bidtime - INTERVAL '5' SECONDS
) WITH (
    'connector' = 'faker',
    'rows-per-second' = '10',
    'fields.bidtime.expression' = '#{date.past ''15'',''SECONDS''}',
    'fields.price.expression' = '#{number.randomDouble ''2'',''10'',''1000''}',
    'fields.item.expression' = '#{Options.option ''laptop'',''phone'',''tablet'',''headphones'',''watch'',''camera'',''speaker''}',
    'fields.bidder.expression' = 'user_#{number.numberBetween ''1000'',''9999''}'
);

-- 2. ItemInfo
CREATE TABLE ItemInfo (
    item_id STRING,
    item_name STRING,
    category STRING,
    valid_from TIMESTAMP(3),
    valid_to TIMESTAMP(3),
    PRIMARY KEY (item_id) NOT ENFORCED
) WITH (
    'connector' = 'faker',
    'rows-per-second' = '2',
    'fields.item_id.expression' = '#{Options.option ''item_001'',''item_002'',''item_003'',''item_004'',''item_005''}',
    'fields.item_name.expression' = '#{Options.option ''Gaming Laptop'',''Smartphone Pro'',''Wireless Earbuds'',''Smart Watch'',''DSLR Camera''}',
    'fields.category.expression' = '#{Options.option ''electronics'',''wearables'',''audio'',''photography''}',
    'fields.valid_from.expression' = '#{date.past ''30'',''DAYS''}',
    'fields.valid_to.expression' = '#{date.future ''30'',''DAYS''}'
);

-- 3. Bid2
CREATE TABLE Bid2 (
    bidtime TIMESTAMP(3),
    price DECIMAL(10, 2),
    item STRING,
    bidder_id BIGINT,
    WATERMARK FOR bidtime AS bidtime - INTERVAL '5' SECONDS
) WITH (
    'connector' = 'faker',
    'rows-per-second' = '5',
    'fields.bidtime.expression' = '#{date.past ''15'',''SECONDS''}',
    'fields.price.expression' = '#{number.randomDouble ''2'',''50'',''800''}',
    'fields.item.expression' = '#{Options.option ''laptop'',''phone'',''tablet'',''headphones'',''watch''}',
    'fields.bidder_id.expression' = '#{number.numberBetween ''10000'',''99999''}'
);

-- 4. ticker
CREATE TABLE Ticker (
    symbol STRING,
    price DOUBLE,
    volume INT,
    rowtime TIMESTAMP(3),
    WATERMARK FOR rowtime AS rowtime - INTERVAL '1' SECOND
) WITH (
    'connector' = 'faker',
    'rows-per-second' = '5',
    'fields.symbol.expression' = '#{Options.option ''AAPL'',''GOOG'',''MSFT'',''AMZN'',''TSLA'',''META'',''NFLX''}',
    'fields.price.expression' = '#{number.randomDouble ''2'',''50'',''300''}',
    'fields.volume.expression' = '#{number.numberBetween ''100'',''10000''}',
    'fields.rowtime.expression' = '#{date.past ''15'',''SECONDS''}'
);

-- 5. Orers
CREATE TABLE Orders (
    order_id STRING,
    user_id BIGINT,
    amount DECIMAL(10, 2),
    order_time TIMESTAMP(3),
    proc_time AS PROCTIME(),
    WATERMARK FOR order_time AS order_time - INTERVAL '30' SECONDS
) WITH (
    'connector' = 'faker',
    'rows-per-second' = '8',
    'fields.order_id.expression' = '#{Internet.uuid}',
    'fields.user_id.expression' = '#{number.numberBetween ''1000'',''10000''}',
    'fields.amount.expression' = '#{number.randomDouble ''2'',''10'',''5000''}',
    'fields.order_time.expression' = '#{date.past ''20'',''SECONDS''}'
);
-- RatesHistory
CREATE TABLE RatesHistory (
    currency STRING,
    rate DECIMAL(10, 4),
    valid_from TIMESTAMP(3),
    valid_to TIMESTAMP(3),
    PRIMARY KEY (currency) NOT ENFORCED,
    WATERMARK FOR valid_to AS valid_to - INTERVAL '1' DAY
) WITH (
    'connector' = 'faker',
    'rows-per-second' = '1',
    'fields.currency.expression' = '#{Options.option ''USD'',''EUR'',''GBP'',''JPY'',''CHF''}',
    'fields.rate.expression' = '#{number.randomDouble ''4'',''0.5'',''1.5''}',
    'fields.valid_from.expression' = '#{date.past ''30'',''DAYS''}',
    'fields.valid_to.expression' = '#{date.future ''30'',''DAYS''}'
);