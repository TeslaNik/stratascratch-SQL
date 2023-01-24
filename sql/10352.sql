with pl as
    (select user_id,
        MAX(timestamp) as pl_time
    from facebook_web_log
    where action = 'page_load'
    GROUP BY user_id, DATE(timestamp)),

pe as
    (select user_id,
        MIN(timestamp) as pe_time
    from facebook_web_log
    where action = 'page_exit'
    GROUP BY user_id, DATE(timestamp))

select pl.user_id, 
    avg(pe.pe_time- pl.pl_time) AS avg_session_time
from pl
inner join pe
on pl.user_id = pe.user_id 
    and DATE(pl.pl_time) = DATE(pe.pe_time)
group by pl.user_id;