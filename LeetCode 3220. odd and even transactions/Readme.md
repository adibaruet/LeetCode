`COALESCE()` means: Return the first non-NULL value.

Example:

```
SELECT COALESCE(NULL, 0);
```

Output: `0`

```
SELECT COALESCE(NULL, NULL, 10);
```

Output: `10`

In your LeetCode problem:

```
COALESCE(SUM(amount) FILTER (WHERE amount % 2 = 1), 0)
```

It means:

- If the sum exists → return the sum.
- If the sum is `NULL` → return `0`.

Easy trick to remember: `COALESCE(NULL, 0)` = If NULL, use 0. 
