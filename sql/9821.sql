with friends as
    (select user_id, friend_id from google_friends_network
        union
    select friend_id, user_id from google_friends_network),

uff as
    (select distinct f1.user_id,
        f2.friend_id as uff
    from friends f1
    inner join friends f2
    on f1.friend_id = f2.user_id and f1.user_id != f2.friend_id)

select b1.user_id,
    COALESCE(counts, 0) AS counts
from (select distinct user_id from friends) b1
left join 
    (select user_id, 
        COUNT(*) AS counts
    from uff
    where (user_id, uff) in (select user_id, friend_id from friends)
    group by user_id) b2
on b1.user_id = b2.user_id
order by b1.user_id;
