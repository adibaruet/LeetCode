# Title Case Conversion in PostgreSQL

A LeetCode SQL problem solved with PostgreSQL. The query converts text into a special title case format.

## Problem in Simple Words

For each row in the `user_content` table, change `content_text` using these rules:

1. Split the text into words by spaces.
2. If a word starts with a non-letter (like `-HE-LL-O-`), leave it exactly as it is.
3. If a word looks like `letters-letters` (like `QUICK-brown`), capitalize the first letter of each part and make the rest lowercase.
4. For any other word (like `foo--bar` or `hi@u`), capitalize only the first letter and make the rest lowercase.
5. Join the words back together with single spaces.

## Table

**user_content**

| Column       | Type    |
| ------------ | ------- |
| content_id   | int     |
| content_text | varchar |

## Examples

| Input                       | Output                      |
| --------------------------- | --------------------------- |
| hello world of SQL          | Hello World Of Sql          |
| the QUICK-brown fox         | The Quick-Brown Fox         |
| foo--bar -baz lOO-daR-@Daz- | Foo--bar -baz Loo-dar-@daz- |
| hi -HE-LL-O-                | Hi -HE-LL-O-                |

## Approach

1. Use `string_to_array` to split the text into words.
2. Use `unnest ... WITH ORDINALITY` to keep each word's position.
3. Use a `CASE` to apply the three rules above:
   - Starts with a non-letter: keep the word.
   - Matches `^[A-Za-z]+(-[A-Za-z]+)+$`: split by `-`, fix each part, join back with `-`.
   - Otherwise: capitalize the first letter, lowercase the rest.
4. Use `string_agg(... ORDER BY position)` to rebuild the text in the original order.

## Solution

```sql
SELECT
    content_id,
    content_text AS original_text,
    (
        SELECT string_agg(
            CASE
                WHEN word ~ '^[^A-Za-z]' THEN word
                WHEN word ~ '^[A-Za-z]+(-[A-Za-z]+)+$' THEN (
                    SELECT string_agg(
                        upper(left(part, 1)) || lower(substring(part FROM 2)),
                        '-' ORDER BY idx
                    )
                    FROM unnest(string_to_array(word, '-'))
                         WITH ORDINALITY AS p(part, idx)
                )
                ELSE upper(left(word, 1)) || lower(substring(word FROM 2))
            END,
            ' ' ORDER BY ord
        )
        FROM unnest(string_to_array(content_text, ' '))
             WITH ORDINALITY AS w(word, ord)
    ) AS converted_text
FROM user_content;
```

## Key Concepts Used

- `string_to_array`: splits text into an array
- `unnest WITH ORDINALITY`: turns an array into rows and keeps the order
- `string_agg ... ORDER BY`: joins rows back into one string in order
- `~` regex match: checks the shape of a word
- `upper`, `lower`, `left`, `substring`: change letter case

## Edge Cases Handled

- Words starting with `-` or `@` stay unchanged
- Double hyphens like `foo--bar`
- Trailing hyphens like `lOO-daR-@Daz-`
- Mixed upper and lower case input

## Author

Humaira Tasnim Adiba
