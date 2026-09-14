SELECT product_id, new_price AS price
FROM (
    SELECT DISTINCT ON (product_id)
           product_id,
           new_price
    FROM Products
    WHERE change_date <= '2019-08-16'
    ORDER BY product_id, change_date DESC
) p

UNION

SELECT product_id, 10 AS price
FROM Products
WHERE product_id NOT IN (
    SELECT product_id
    FROM Products
    WHERE change_date <= '2019-08-16'
);
