SELECT ROUND(
    COUNT(*) FILTER (
        WHERE EXISTS (
            SELECT 1
            FROM Activity a2
            WHERE a2.player_id = a1.player_id
              AND a2.event_date = a1.first_date + 1
        )
    )::decimal / COUNT(*),
    2
) AS fraction
FROM (
    SELECT 
        player_id,
        MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
) a1;
