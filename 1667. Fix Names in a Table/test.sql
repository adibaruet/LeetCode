SELECT user_id, INITCAP(LOWER(name)) AS name
FROM Users
ORDER BY user_id;
