with calls_by_day as
    (select *,
        ROW_NUMBER() OVER(PARTITION BY caller_id, day ORDER BY date_called ASC) as first_call,
        ROW_NUMBER() OVER(PARTITION BY caller_id, day ORDER BY date_called DESC) as last_call
    from 
        (select *, 
            date_called::DATE as day
        from caller_history) b1),

first_and_last_calls as
    (select distinct caller_id, recipient_id, day
    from calls_by_day
    where first_call = 1 or last_call = 1)

select caller_id, recipient_id, day 
from
    (select caller_id, recipient_id, day, COUNT(recipient_id) OVER(PARTITION BY caller_id, day) as num_unique_recipients
    from first_and_last_calls) b2
where num_unique_recipients = 1;