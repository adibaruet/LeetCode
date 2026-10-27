
SELECT
    content_id,
    content_text AS original_text,
    (
        SELECT string_agg(
            CASE
                WHEN word ~ '^[^A-Za-z]' THEN word
                WHEN word LIKE '%-%' THEN
                    regexp_replace(
                        word,
                        '(^|-)([A-Za-z]+)',
                        '\1' || '\2',
                        'g'
                    )
                ELSE upper(left(word, 1)) || lower(substring(word FROM 2))
            END,
            ' ' ORDER BY ord
        )
        FROM unnest(string_to_array(content_text, ' '))
             WITH ORDINALITY AS words(word, ord)
    ) AS converted_text
FROM user_content;
