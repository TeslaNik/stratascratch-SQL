with temp as
    (select user_id as user, 
        friend_id as friend
    from google_friends_network
    UNION
    select user_id as user, friend_id as friend
    from google_friends_network),

uff as
    (select distinct t1.user,
        t2.friend as o_friend,
        CASE WHEN t2.friend in (select friend from temp where temp.user = t1.user) then 1 else 0 end as uff
    from temp t1
    inner join temp t2
    on t1.friend = t2.user 
        and t1.user != t2.friend)

select a.user,
    b.num_uff
from (select distinct temp.user 
        from temp) a
left join (select uff.user, 
                SUM(uff.uff) as num_uff 
            from uff 
            group by uff.user) b
on a.user = b.user
order by a.user;