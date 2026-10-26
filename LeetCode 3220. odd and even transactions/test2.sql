
SELECT
    transaction_date,
    SUM(amount * (amount % 2)) AS odd_sum,
    SUM(amount * (1 - amount % 2)) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date;
