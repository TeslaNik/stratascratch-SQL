with pv as
    (select post_id,
        COUNT(*) as no_views
    from facebook_post_views
    group by post_id),

pk as
    (select post_id,
        UNNEST(STRING_TO_ARRAY(regexp_replace(post_keywords,'[\[\]#]','','g'),',')) as keywords
    from facebook_posts)

SELECT pk.keywords,
    COALESCE(SUM(pv.no_views),0) as total_views
FROM pk
left join pv
on pk.post_id = pv.post_id
group by pk.keywords
order by total_views desc;