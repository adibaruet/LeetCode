
# 1. REGEXP – Pattern Matching

Meaning: `REGEXP` checks whether a string matches a particular pattern.

Think of it as a search tool that checks the structure of text.

Example:

```
SELECT *
FROM logs
WHERE ip REGEXP '^[0-9]+$';
```

This finds IP values that contain only digits (without dots).

Some useful REGEXP symbols:

| Symbol       | Meaning                             | Example          |
| ------------ | ----------------------------------- | ---------------- |
| `^`          | Start of string                     | `^A`             |
| `$`          | End of string                       | `A$`             |
| `[0-9]`      | Any digit from 0–9                  | `[0-9]`          |
| `[0-9]+`     | One or more digits                  | `123`            |
| `[0-9]{1,3}` | 1 to 3 digits                       | `1`, `12`, `123` |
| `.`          | Any character in regex              | `a.c`            |
| `\\.`        | A literal dot in MySQL regex string | `192.168`        |
| `()`         | Groups patterns                     | `(ab)`           |
| `OR`         | Either condition can match          | SQL condition    |

Example:

```
SELECT *
FROM logs
WHERE ip REGEXP '^[0-9]{1,3}$';
```

Matches:

- `12`
- `123`
- `5`

Does not match:

- `1234`
- `abc`

Remember: `REGEXP` = Check a text pattern.

# 2. SUBSTRING_INDEX() – Extracting Text

Meaning: It extracts a part of a string based on a separator.

Syntax:

```
SUBSTRING_INDEX(string, delimiter, count)
```

There are three arguments:

- `string` = Original text.
- `delimiter` = Separator.
- `count` = How many parts to extract.

Let's take this IP:

```
192.168.1.10
```

Examples:

| SQL                            | Result      |
| ------------------------------ | ----------- |
| `SUBSTRING_INDEX(ip, '.', 1)`  | `192`       |
| `SUBSTRING_INDEX(ip, '.', 2)`  | `192.168`   |
| `SUBSTRING_INDEX(ip, '.', 3)`  | `192.168.1` |
| `SUBSTRING_INDEX(ip, '.', -1)` | `10`        |
| `SUBSTRING_INDEX(ip, '.', -2)` | `1.10`      |

Important trick:

- Positive count → Start from the left.
- Negative count → Start from the right.

You can also combine functions.

```
SELECT
SUBSTRING_INDEX(
    SUBSTRING_INDEX(ip, '.', 2),
    '.',
    -1
)
FROM logs;
```

Output:

```
168
```

Why?

1. First function extracts `192.168`.
2. Second function extracts the last part: `168`.

Remember: `SUBSTRING_INDEX()` = Extract a specific part of text.

# 3. CAST() – Changing Data Types

Meaning: `CAST()` converts a value from one data type to another.

For example, sometimes numbers are stored as text.

```
SELECT CAST('255' AS UNSIGNED);
```

Output:

```
255
```

Why do we need it?

Suppose we have:

```
SELECT '256' > '255';
```

When values are treated as strings, comparisons can behave differently from numerical comparisons.

Instead:

```
SELECT CAST('256' AS UNSIGNED) > 255;
```

Output: `1` (TRUE).

Some common conversions:

| SQL                             | Result     |
| ------------------------------- | ---------- |
| `CAST('123' AS UNSIGNED)`       | 123        |
| `CAST('12.5' AS DECIMAL(10,2))` | 12.50      |
| `CAST(123 AS CHAR)`             | '123'      |
| `CAST('2026-11-12' AS DATE)`    | 2026-11-12 |

Remember: `CAST()` = Convert data type.
