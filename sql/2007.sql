WITH t1 as
    (select u.country,
    SUM(CASE WHEN to_char(created_at,'YYYY-MM') = '2019-12' THEN number_of_comments ELSE 0 END) as dec19_comments,
    SUM(CASE WHEN to_char(created_at,'YYYY-MM') = '2020-01' THEN number_of_comments ELSE 0 END) as jan20_comments
    from fb_comments_count c
    inner join fb_active_users u
    on c.user_id = u.user_id
    group by u.country)

select country
from
    (select country,
        DENSE_RANK() over(order by dec19_comments desc) as dec19_rank,
        DENSE_RANK() over(order by jan20_comments desc) as jan20_rank
    from t1) b
where jan20_rank < dec19_rank;