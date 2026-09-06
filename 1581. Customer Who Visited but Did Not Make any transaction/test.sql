SELECT v.customer_id,count(v.visit_id) AS count_no_trans 
from visits v
LEFT JOIN transactions t using(visit_id) 
WHERE t.transaction_id is NULL 
GROUP BY customer_id;
