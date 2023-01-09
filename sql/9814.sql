with t1 as 
    (select lower(UNNEST(STRING_TO_ARRAY(contents,' '))) as words
    from google_file_store)

select words, 
    count(*) AS frequency
from t1
where words in ('bull', 'bear')
group by words;