with sessions as
    (select * from
        (select user_id, session_id,
            MIN(step_id) as min_step,
            MAX(step_id) as max_step
        from google_fit_location
        group by user_id, session_id) b
        where min_step != max_step),
    
coordinates as
    (select s.user_id,
        -- s.session_id, s.min_step, s.max_step,
        gfl1.latitude as lat1,
        gfl1.longitude as lon1,
        gfl2.latitude as lat2,
        gfl2.longitude as lon2
    from sessions s
    inner join google_fit_location gfl1
    on s.user_id = gfl1.user_id 
        and s.session_id = gfl1.session_id 
        and s.min_step = gfl1.step_id
    inner join google_fit_location gfl2
    on s.user_id = gfl2.user_id 
        and s.session_id = gfl2.session_id 
        and s.max_step = gfl2.step_id),
    
distances as
    (select user_id,
        ACOS(
            SIN(lat1*pi()/180) * SIN(lat2*pi()/180) +
            COS(lat1*pi()/180) * COS(lat2*pi()/180) * COS(lon2*pi()/180 - lon1*pi()/180)
            )*6371 as curv_dist,
        SQRT((lat2-lat1)^2 + (lon2-lon1)^2)*111 as flat_dist
    from coordinates)


select user_id,
    AVG(curv_dist) as avg_curv_dist,
    AVG(flat_dist) as avg_flat_dist
from distances 
group by user_id
order by user_id;