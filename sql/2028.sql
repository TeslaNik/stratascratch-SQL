with t1 as
    (select distinct user_id, 
        extract(MONTH FROM time_id) as mth
    from fact_events),

t2 as
    (select user_id, 
        mth, 
        RANK() OVER(partition by user_id ORDER BY mth) as ranking
    from t1)

select mth, 
    new_users*1.0/NULLIF(old_users, 0) as new_to_old_ratio
FROM
    (select mth, 
        COUNT(*) FILTER(WHERE ranking = 1) as new_users,
        COUNT(*) FILTER(WHERE ranking != 1) as old_users
    from t2
    group by mth) b
order by mth;