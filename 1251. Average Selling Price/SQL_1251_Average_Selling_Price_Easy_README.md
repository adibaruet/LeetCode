# SQL 1251 — Average Selling Price
## Easy Explanation (PostgreSQL)

This problem looks scary at first, but it is really just:

**JOIN → calculate total money → calculate total units → divide → ROUND**

---

## 1. What are the two tables?

### Prices

| product_id | start_date | end_date | price |
|---|---|---|---:|
| 1 | 2019-02-17 | 2019-02-28 | 5 |
| 1 | 2019-03-01 | 2019-03-22 | 20 |
| 2 | 2019-02-01 | 2019-02-20 | 15 |
| 2 | 2019-02-21 | 2019-03-31 | 30 |

This tells us:

> "During this date range, this product had this price."

### UnitsSold

| product_id | purchase_date | units |
|---|---|---:|
| 1 | 2019-02-25 | 100 |
| 1 | 2019-03-01 | 15 |
| 2 | 2019-02-10 | 200 |
| 2 | 2019-03-22 | 30 |

This tells us:

> "On this date, this many units were sold."

---

# 2. First problem: How do we JOIN them?

Both tables have:

```sql
product_id
```

So we know the basic JOIN is:

```sql
FROM Prices p
JOIN UnitsSold u
    ON p.product_id = u.product_id
```

BUT this is not enough.

Why?

Because the same product can have different prices on different dates.

For example, Product 1:

```text
Feb 17 → Feb 28    price = 5
Mar 1  → Mar 22    price = 20
```

So we also need to check:

> Was the purchase made during this price period?

We write:

```sql
u.purchase_date BETWEEN p.start_date AND p.end_date
```

Therefore:

```sql
FROM Prices p
JOIN UnitsSold u
    ON p.product_id = u.product_id
   AND u.purchase_date BETWEEN p.start_date AND p.end_date
```

---

# 3. What does BETWEEN mean?

This:

```sql
u.purchase_date BETWEEN p.start_date AND p.end_date
```

means:

```text
purchase_date >= start_date
AND
purchase_date <= end_date
```

For example:

```text
Price period:
Feb 17 → Feb 28
Price = 5

Purchase:
Feb 25

Feb 25 is between Feb 17 and Feb 28
→ price = 5
```

---

# 4. After the JOIN

For the example, the matching rows become:

| product_id | price | units |
|---|---:|---:|
| 1 | 5 | 100 |
| 1 | 20 | 15 |
| 2 | 15 | 200 |
| 2 | 30 | 30 |

Now the hard part is finished.

---

# 5. Why can't we use AVG(price)?

You might think:

```sql
AVG(price)
```

But that is WRONG.

For Product 1:

```text
100 units were sold at $5
15 units were sold at $20
```

The $5 price affected **100 products**.

The $20 price affected only **15 products**.

So we cannot simply average:

```text
(5 + 20) / 2 = 12.50
```

That ignores how many units were sold.

---

# 6. What should we calculate?

We need:

```text
Total money earned
------------------
Total units sold
```

For each sale:

```text
price × units
```

So:

```sql
SUM(p.price * u.units)
```

means:

> Add all the money made.

And:

```sql
SUM(u.units)
```

means:

> Add all units sold.

Therefore:

```sql
SUM(p.price * u.units) / SUM(u.units)
```

---

# 7. Example: Product 1

Product 1:

```text
100 units × $5  = $500
15 units × $20   = $300
```

Total money:

```text
500 + 300 = 800
```

Total units:

```text
100 + 15 = 115
```

Average selling price:

```text
800 / 115 = 6.9565...
```

Rounded:

```text
6.96
```

---

# 8. Why GROUP BY?

We need an answer for **each product**.

So:

```sql
GROUP BY p.product_id
```

means:

> Put all rows belonging to the same product together.

For example:

```text
Product 1
    5 × 100
    20 × 15

Product 2
    15 × 200
    30 × 30
```

Then SQL calculates the average separately for each product.

---

# 9. Why LEFT JOIN?

The question has an important sentence:

> If a product does not have any sold units, its average selling price is 0.

Imagine:

```text
Prices
Product 1
Product 2
Product 3

UnitsSold
Product 1
Product 2
```

Product 3 has no sales.

If we use:

```sql
JOIN
```

Product 3 disappears.

But we need Product 3 in the answer with:

```text
0
```

So we use:

```sql
LEFT JOIN
```

This keeps all products from `Prices`.

---

# 10. What is COALESCE?

When Product 3 has no sales, the calculation can produce:

```text
NULL
```

But the problem wants:

```text
0
```

So we use:

```sql
COALESCE(calculation, 0)
```

It means:

> If the calculation is NULL, use 0.

Simple example:

```sql
COALESCE(NULL, 0)
```

Result:

```text
0
```

But:

```sql
COALESCE(10, 0)
```

Result:

```text
10
```

---

# 11. Why ROUND?

The question says:

> average_price should be rounded to 2 decimal places.

So:

```sql
ROUND(number, 2)
```

Example:

```sql
ROUND(6.9565, 2)
```

gives:

```text
6.96
```

In PostgreSQL, we can write:

```sql
ROUND(
    SUM(p.price * u.units)::numeric / SUM(u.units),
    2
)
```

The `::numeric` makes sure PostgreSQL performs the division correctly for `ROUND`.

---

# 12. Final Query

```sql
SELECT
    p.product_id,
    ROUND(
        COALESCE(
            SUM(p.price * u.units)::numeric / SUM(u.units),
            0
        ),
        2
    ) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
    ON p.product_id = u.product_id
   AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```

---

# 13. Read the query like English

Don't try to memorize the whole query.

Read it from top to bottom:

```sql
SELECT p.product_id
```

→ Give me the product ID.

```sql
SUM(p.price * u.units)
```

→ Calculate total money.

```sql
SUM(u.units)
```

→ Calculate total units.

```sql
SUM(price × units) / SUM(units)
```

→ Calculate average selling price.

```sql
ROUND(..., 2)
```

→ Keep 2 decimal places.

```sql
FROM Prices p
```

→ Start with the Prices table.

```sql
LEFT JOIN UnitsSold u
```

→ Connect the sales table.

```sql
ON p.product_id = u.product_id
```

→ Match the same product.

```sql
AND u.purchase_date BETWEEN p.start_date AND p.end_date
```

→ Make sure the purchase happened during that price period.

```sql
GROUP BY p.product_id
```

→ Do the calculation separately for each product.

---

# 14. The 4 things you should remember

For this problem, remember these:

### ① Match product

```sql
p.product_id = u.product_id
```

### ② Match date

```sql
u.purchase_date BETWEEN p.start_date AND p.end_date
```

### ③ Weighted average

```sql
SUM(price * units) / SUM(units)
```

### ④ One answer per product

```sql
GROUP BY product_id
```

That's the entire idea.

---

# 15. Mini cheat sheet

| SQL | Meaning |
|---|---|
| `JOIN` | Match rows from two tables |
| `LEFT JOIN` | Keep everything from the left table |
| `ON` | Tell SQL how tables are connected |
| `BETWEEN` | Inside a range |
| `SUM()` | Add values |
| `GROUP BY` | Make groups |
| `COALESCE()` | Replace NULL |
| `ROUND()` | Round a number |

---

# 16. Don't memorize this problem

Instead, ask yourself these questions:

```text
1. Which tables do I need?
        ↓
2. How are they connected?
        ↓
3. Which price belongs to each sale?
        ↓
4. How much money was made?
        ↓
5. How many units were sold?
        ↓
6. Do I need one answer per product?
        ↓
7. Do I need rounding?
        ↓
8. What happens if there are no sales?
```

For this problem, the answers are:

```text
Prices + UnitsSold
        ↓
product_id
        ↓
purchase_date BETWEEN start_date AND end_date
        ↓
price × units
        ↓
SUM(units)
        ↓
GROUP BY product_id
        ↓
ROUND(..., 2)
        ↓
LEFT JOIN + COALESCE
```

That is the logic you should understand. The final SQL is just the logic written in SQL.
