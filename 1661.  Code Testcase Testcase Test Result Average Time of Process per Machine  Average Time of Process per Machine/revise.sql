SELECT 
    machine_id,
  ROUND(
    CAST(SUM(CASE WHEN activity_type = 'start' THEN -timestamp ELSE timestamp END) AS numeric)
    / COUNT(DISTINCT process_id)
, 3) AS processing_time
FROM Activity
GROUP BY machine_id;
