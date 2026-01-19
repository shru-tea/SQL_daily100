-- Write a SQL query to report the capital gain/loss for each stock 
-- Capital gain/loss of a stock is the total gain or loss after buying and selling
-- the stock one or many times
SELECT
stock_name,
diff AS capital_gain_loss
FROM
(
SELECT
stock_name,
SUM(CASE WHEN operation = 'Sell' THEN price END) as sell_price,
SUM(CASE WHEN operation = 'Buy' THEN price END) as buy_price,
SUM(CASE WHEN operation = 'Sell' THEN price END) - SUM(CASE WHEN operation = 'Buy' THEN price END) 
AS diff
FROM table_ddl.stocks
GROUP BY stock_name) t
ORDER BY diff DESC;


