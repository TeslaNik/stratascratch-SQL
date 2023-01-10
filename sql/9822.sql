select AVG(t2.num_friends) as avg_num_friends_per_user
from
    (select t1.user,
        COUNT(friend) as num_friends
    from
        (select user_id as user,
            friend_id as friend
        from google_friends_network
        union
        select friend_id as user, 
            user_id as friend
        from google_friends_network) t1
        group by t1.user) t2;