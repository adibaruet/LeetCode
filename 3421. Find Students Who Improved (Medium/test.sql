SELECT
    student_id,
    subject,
    MIN(score) FILTER (WHERE exam_date = first_date) AS first_score,
    MAX(score) FILTER (WHERE exam_date = last_date) AS latest_score
FROM (
    SELECT *,
           MIN(exam_date) OVER (
               PARTITION BY student_id, subject
           ) AS first_date,
           MAX(exam_date) OVER (
               PARTITION BY student_id, subject
           ) AS last_date,
           COUNT(*) OVER (
               PARTITION BY student_id, subject
           ) AS exam_count
    FROM Scores
) s
WHERE exam_count >= 2
GROUP BY student_id, subject
HAVING
    MAX(score) FILTER (WHERE exam_date = last_date)
    >
    MIN(score) FILTER (WHERE exam_date = first_date)
ORDER BY student_id, subject;
