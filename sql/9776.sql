with temp as
    (select distinct poster,
        UNNEST(STRING_TO_ARRAY(REGEXP_REPLACE(post_keywords,'[\[\]#]','','g'),',')) as keyword
    from facebook_posts),

num_key as
    (select poster, 
        COUNT(keyword) as num_keywords
    from temp
    group by poster),

poster_combo as
    (select nk1.poster as poster,
        nk2.poster as o_poster
    from num_key nk1
    cross join num_key nk2
    where nk1.poster != nk2.poster),

num_same_key as
    (select t1.poster as poster,
        t2.poster as o_poster,
        COUNT(t2.poster) as num_same_keywords
    from temp t1
    inner join temp t2
    on t1.keyword = t2.keyword and t1.poster != t2.poster
    group by t1.poster, t2.poster)

select pc.poster,
    pc.o_poster,
    COALESCE(nsk.num_same_keywords,0)*100.0/nk.num_keywords as perc_common
from poster_combo pc
left join num_same_key as nsk
on pc.poster = nsk.poster and pc.o_poster = nsk.o_poster
inner join num_key nk
on pc.poster = nk.poster;