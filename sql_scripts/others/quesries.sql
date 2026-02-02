// default_catalog.default_database.bounded_pageviews
set 'sql-client.execition.result-mode' = 'table';
select * from 
cast()

ALter table 'streaming_pageviews' set ('rows-per-seconds' = '10');


select 
 `open` as open_p,
  CAST(`open` as DECIMAL(10,2)) as open_d
 from default_catalog.default_database.stock_candles ;

select 



WITH CombinedBids AS (
    SELECT item, bidtime, price, 'bid1' AS source FROM Bid
    UNION ALL
    SELECT item, bidtime, price, 'bid2' AS source FROM Bid2
),
BidWindows AS (
    SELECT 
        item,
        TUMBLE_START(bidtime, INTERVAL '1' MINUTE) AS window_start,
        TUMBLE_END(bidtime, INTERVAL '1' MINUTE) AS window_end,
        AVG(CASE WHEN source = 'bid1' THEN price END) AS avg_price_bid1,
        AVG(CASE WHEN source = 'bid2' THEN price END) AS avg_price_bid2
    FROM CombinedBids
    GROUP BY item, TUMBLE(bidtime, INTERVAL '1' MINUTE)
)
SELECT 
    item,
    window_start,
    window_end,
    COALESCE(avg_price_bid1, 0) AS avg_price_bid1,
    COALESCE(avg_price_bid2, 0) AS avg_price_bid2,
    ABS(COALESCE(avg_price_bid1, 0) - COALESCE(avg_price_bid2, 0)) AS price_difference
FROM BidWindows