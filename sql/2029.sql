with t1 as
    (select client_id, user_id,
        AVG(CASE WHEN event_type LIKE '%call%' then 1 else 0 end) AS perc_call
    from fact_events
    GROUP BY client_id, user_id
    order by user_id)

select client_id, 
    COUNT(user_id) AS num_users
from t1
where perc_call >= 0.5
GROUP BY client_id
ORDER BY num_users DESC limit 1;