with t1 as
    (select UNNEST(STRING_TO_ARRAY(words1,',')) AS words
    from google_word_lists),

t2 as
    (select UNNEST(STRING_TO_ARRAY(words2,',')) AS words
    from google_word_lists)

select words from t1
where words in (select words from t2);