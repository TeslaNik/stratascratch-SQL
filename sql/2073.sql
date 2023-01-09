with t1 as
    (select session_id,
        EXTRACT(EPOCH FROM session_endtime - session_starttime) as duration
    from user_sessions)

select * 
from
    (select p.post_id,
        SUM(p.perc_viewed*t1.duration*1.0/100) as total_time
    from post_views p
    inner join t1
    on p.session_id = t1.session_id
    group by p.post_id) b
where total_time > 5;