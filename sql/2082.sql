with temp as
    (select a.train_id,
        a.arrival_time,
        d.departure_time
    from train_arrivals a
    inner join train_departures d
    on a.train_id = d.train_id), 


common_times as
    (select t1.train_id, -- t1.arrival_time, t1.departure_time,
        t2.train_id as concurrent_train --, t2.arrival_time, t2.departure_time
    from temp t1
    inner join temp t2
    on (t1.train_id != t2.train_id) 
        AND NOT 
        ((t2.arrival_time < t1.arrival_time and t2.departure_time < t1.arrival_time) 
            OR (t2.arrival_time > t1.departure_time and t2.departure_time > t1.departure_time))
    )
    
SELECT MAX(concurrent_trains)  AS min_num_platforms_req       
FROM
    (select train_id, 
        COUNT(*) as concurrent_trains 
    from common_times 
    group by train_id) b;
