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
