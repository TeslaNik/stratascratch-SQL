with sd as
    (select user_id,
        MIN(timestamp) as min_sd_time
    from facebook_web_log
    where action = 'scroll_down'
    group by user_id),

pl as
    (select f1.user_id,
        MAX(f1.timestamp) as max_pl_time,
        sd.min_sd_time,
        (sd.min_sd_time -MAX(f1.timestamp)) as time_difference
    from facebook_web_log f1
    inner join sd
    on f1.user_id = sd.user_id 
        and f1.action = 'page_load' 
        and f1.timestamp <= sd.min_sd_time
    group by f1.user_id, sd.min_sd_time)

select * 
from pl
where time_difference in (select min(time_difference) from pl);