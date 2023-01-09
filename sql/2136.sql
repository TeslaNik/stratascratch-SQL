WITH t1 as
    (select cust_id,
        state,
        (LEAD(timestamp) OVER (PARTITION BY cust_id order by timestamp asc))::TIME - timestamp::TIME as duration
    from cust_tracking)

select cust_id,
    SUM(duration)/3600 as total_session_hrs
from t1
where state = 1
group by cust_id;