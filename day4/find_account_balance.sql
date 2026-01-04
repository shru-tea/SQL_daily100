/*
Given a table containing information about bank deposits and withdrawals made using Paypal, write a query to retrieve the final account balance for each account, taking into account all the transactions recorded in the table with the assumption that there are no missing transactions.
*/

SELECT 
account_id,
SUM(
  CASE WHEN transaction_type = 'Deposit' THEN amount
       WHEN transaction_type = 'Withdrawal' THEN -1*amount
       ELSE 0
  END
  ) AS find_balance
FROM transactions
GROUP BY account_id ;