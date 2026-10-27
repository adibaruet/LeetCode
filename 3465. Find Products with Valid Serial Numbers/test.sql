SELECT *
FROM products
WHERE description ~ '(^|[^A-Za-z0-9])SN[0-9]{4}-[0-9]{4}([^0-9]|$)'
ORDER BY product_id;
