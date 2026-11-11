# 3451. Find Invalid IP Addresses

**Difficulty:** Hard  
**Language:** MySQL  
**Topic:** REGEXP, SUBSTRING_INDEX, CAST, GROUP BY

## Problem
Find invalid IPv4 addresses from the `logs` table and count how many times each invalid IP appears.

An IP address is invalid if:
- Any octet is greater than 255.
- Any octet has leading zeros.
- It does not contain exactly 4 octets.

## Solution

```sql
SELECT
    ip,
    COUNT(*) AS invalid_count
FROM logs
WHERE
    ip NOT REGEXP '^([0-9]{1,3}\\.){3}[0-9]{1,3}$'
    OR ip REGEXP '(^|\\.)(0[0-9]+)(\\.|$)'
    OR CAST(SUBSTRING_INDEX(ip, '.', 1) AS UNSIGNED) > 255
    OR CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) AS UNSIGNED) > 255
    OR CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) AS UNSIGNED) > 255
    OR CAST(SUBSTRING_INDEX(ip, '.', -1) AS UNSIGNED) > 255
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;
```

## Key Concepts

- **REGEXP:** Checks whether an IP matches a pattern.
- **SUBSTRING_INDEX():** Extracts individual octets.
- **CAST():** Converts text into a number.
- **COUNT():** Counts repeated invalid IPs.
- **GROUP BY:** Groups identical IP addresses.
- **ORDER BY:** Sorts the result.

