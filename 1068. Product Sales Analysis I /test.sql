Select p.product_name, s.year, s.price from sales s
leftjoin /join product p ON p.product_id=s.product_id
