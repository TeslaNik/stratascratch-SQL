with t1 as
    (select user1 as user_id, user2 as friend_id from facebook_friends
    union
    select user2, user1 from facebook_friends)

select t1.user_id,
    count(friend_id)*100.0/(select count(distinct t1.user_id) from t1) as perc_popularity
from t1
group by t1.user_id
order by t1.user_id;