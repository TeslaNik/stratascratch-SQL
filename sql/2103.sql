with t1 as
    (select u.video_id,
        COUNT(f.flag_id) as num_flags,
        SUM(cast(f.reviewed_by_yt as integer)) as num_rev_flags
    from user_flags u
    inner join flag_review f
    on u.flag_id = f.flag_id
    group by u.video_id)

select video_id,
    num_rev_flags
from t1
where num_flags in (select max(num_flags) from t1);