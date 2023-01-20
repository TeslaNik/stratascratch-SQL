with t1 as
    (select f1.date,
        --f1.action as sent,
        f2.action as action
    from fb_friend_requests f1
    inner join fb_friend_requests f2 
    on f1.user_id_sender = f2.user_id_sender
        and f1.user_id_receiver = f2.user_id_receiver
        and f1.action = 'sent')

select date,
    sum(case when action = 'accepted' then 1 else 0 end)*1.0/sum(case when action = 'sent' then 1 else 0 end) as acc_rate
from t1 
group by date;

