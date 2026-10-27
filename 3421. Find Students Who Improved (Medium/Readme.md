# 3421. Find Students Who Improved

**Difficulty:** Medium  
**Platform:** LeetCode  
**Topics:** PostgreSQL, Window Functions, Aggregation

## Problem Summary

Find students whose latest score in a subject is higher than their first score. A student must have taken exams in the same subject on at least two different dates.

Return `student_id`, `subject`, `first_score`, and `latest_score`, ordered by `student_id` and `subject` in ascending order.

## SQL Solution

```sql
WITH ranked_scores AS (
    SELECT
        student_id,
        subject,
        score,
        exam_date,
        ROW_NUMBER() OVER (
            PARTITION BY student_id, subject
            ORDER BY exam_date ASC
        ) AS first_rank,
        ROW_NUMBER() OVER (
            PARTITION BY student_id, subject
            ORDER BY exam_date DESC
        ) AS last_rank,
        COUNT(*) OVER (
            PARTITION BY student_id, subject
        ) AS exam_count
    FROM Scores
)
SELECT
    student_id,
    subject,
    MAX(CASE WHEN first_rank = 1 THEN score END) AS first_score,
    MAX(CASE WHEN last_rank = 1 THEN score END) AS latest_score
FROM ranked_scores
WHERE exam_count >= 2
GROUP BY student_id, subject
HAVING
    MAX(CASE WHEN last_rank = 1 THEN score END)
    >
    MAX(CASE WHEN first_rank = 1 THEN score END)
ORDER BY student_id, subject;
```

## Approach

1. **`ROW_NUMBER()`** assigns rank 1 to the earliest and latest exam for each student and subject.
2. **`COUNT(*)`** counts how many exams each student took in that subject.
3. **`CASE WHEN`** extracts the first and latest scores.
4. **`HAVING`** keeps only students whose latest score is greater than their first score.
5. **`ORDER BY`** sorts the final results as required.

## Key Takeaway

Use window functions to identify the first and latest records within each group, then use `HAVING` to filter groups based on their scores.

## Complexity

- **Time:** \(O(n \log n)\) in a typical sorting-based execution.
- **Space:** Depends on the database execution plan and window-function sorting requirements.

Here, \(n\) is the number of rows in the `Scores` table.
