with t1 as 
    (select contents from google_file_store
    union all
    select words1 from google_word_lists
    union all 
    select words2 from google_word_lists),

t2 as
    (select UNNEST(regexp_split_to_array(regexp_replace(lower(contents), '[^\w]+','','g'),'')) as letters
    From t1)

select letters,
    COUNT(*) as counts
from t2
group by letters
order by counts desc, letters asc limit 3;