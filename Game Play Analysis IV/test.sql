SELECT 
    ROUND(
        SUM(player_login::int)::decimal / COUNT(DISTINCT player_id),
        2
    ) AS fraction
FROM (
    SELECT 
        player_id,
        event_date,
        event_date - MIN(event_date) OVER (PARTITION BY player_id) = 1 AS player_login
    FROM Activity
) AS newtable;
