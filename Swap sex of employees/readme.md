

> **`SELECT` = Look at the data**
> **`UPDATE` = Change the data**

### In your problem

The question says:

> "swap all `f` and `m` values"

That means the database values themselves must change.

Suppose the table starts as:

| id | name | sex | salary |
| -: | ---- | --- | -----: |
|  1 | A    | m   |  50000 |
|  2 | B    | f   |  60000 |

If you use:

```sql
SELECT
    id,
    name,
    CASE
        WHEN sex = 'm' THEN 'f'
        WHEN sex = 'f' THEN 'm'
    END AS sex,
    salary
FROM Salary;
```

You'll **see**:

| id | name | sex | salary |
| -: | ---- | --- | -----: |
|  1 | A    | f   |  50000 |
|  2 | B    | m   |  60000 |

But the actual table is still:

| id | name | sex |
| -: | ---- | --- |
|  1 | A    | m   |
|  2 | B    | f   |

`SELECT` did **not change anything**.

---

## `UPDATE` actually changes it

```sql
UPDATE Salary
SET sex = CASE
    WHEN sex = 'm' THEN 'f'
    WHEN sex = 'f' THEN 'm'
END;
```

Now the actual table becomes:

| id | name | sex |
| -: | ---- | --- |
|  1 | A    | f   |
|  2 | B    | m   |

So if the question says:

### "Return/show/find..."

Usually think:

```sql
SELECT
```

Examples:

> Find employees earning more than 50,000.

```sql
SELECT name
FROM Employee
WHERE salary > 50000;
```

You're just **finding/showing** data.

---

### "Change/update/set/replace/delete..."

Think about a data-modification command.

> Change all `f` to `m`.

```sql
UPDATE Salary
SET sex = 'm'
WHERE sex = 'f';
```

Here you're **changing** the database.

---

## The 4 commands you should recognize

| Command  | What it does | Easy meaning |
| -------- | ------------ | ------------ |
| `SELECT` | Reads data   | **Show**     |
| `INSERT` | Adds data    | **Add**      |
| `UPDATE` | Changes data | **Change**   |
| `DELETE` | Removes data | **Delete**   |

So when you read a SQL problem, first ask:

> **"Am I being asked to see data, or change data?"**

For **Swap Salary**, you're being asked to **change the existing values**, so `UPDATE` is the correct command.

One more important thing: **`CASE` itself does not change data.** `CASE` only decides what value to produce. The `UPDATE ... SET` is what actually writes that value into the table.
