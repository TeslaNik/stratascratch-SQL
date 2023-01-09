with t1 as
    (select user_id,
        session_type,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY session_start asc) AS session_order
    from twitch_sessions
    order by user_id, session_start asc),
    
viewers as
    (select distinct user_id 
    from t1 
    where session_type = 'viewer' 
        and session_order = 1)

select user_id,
    COUNT(*) FILTER(WHERE session_type = 'streamer') as streamer_sessions
from t1
WHERE user_id in (select user_id from viewers)
group by user_id
order by streamer_sessions desc, user_id asc;