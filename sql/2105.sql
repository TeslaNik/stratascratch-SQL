with t1 as 
    (select u.user_firstname,
        u.user_lastname,
        u.video_id,
        f.flag_id,
        f.reviewed_date,
        f.reviewed_outcome
    from user_flags u
    inner join flag_review f
    on u.flag_id = f.flag_id
        and f.reviewed_by_yt = TRUE),
    
t2 as
    (select user_firstname,
        user_lastname,
        --COUNT(flag_id) as num_flags,
        MAX(reviewed_date) as latest_review_date
    from t1
    GROUP BY user_firstname, user_lastname
    HAVING COUNT(flag_id) >1),
    
t3 as
    (select reviewed_date,
        COUNT(DISTINCT video_id) as num_removed_vids
    from t1
    where reviewed_outcome = 'REMOVED'
    group by reviewed_date)

select t2.*,
    COALESCE(t3.num_removed_vids,0) AS num_removed_vids
from t2
left join t3
on t2.latest_review_date = t3.reviewed_date;