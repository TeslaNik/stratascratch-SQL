with t1 as
    (select unnest(string_to_array(words1,',')) as words
    from google_word_lists
    union
    select unnest(string_to_array(words2,',')) as words
    from google_word_lists)

select words
from
    (select words,
        length(regexp_replace(words,'[^aeiou]','','g')) as num_vowels
    from t1) t2
where num_vowels =2;
