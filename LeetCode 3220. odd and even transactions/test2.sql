
SELECT
    transaction_date,
    SUM(amount) FILTER (WHERE amount % 2 = 1) AS odd_sum,
    SUM(amount) FILTER (WHERE amount % 2 = 0) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date;
