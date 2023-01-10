select 'wacky.txt' as filename,
    ARRAY_TO_STRING(ARRAY_AGG(contents) ,' ') as contents
from
    (select
        UNNEST(STRING_TO_ARRAY(lower(contents),' ')) as contents
    from google_file_store
    WHERE filename = 'final.txt'
    order by contents) b;