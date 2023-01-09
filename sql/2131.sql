with t1 as
    (select distinct * from user_streaks where date_visited <= '2022-08-10'),

t2 as
    (select user_id,
        date_visited, 
        date_visited - (ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY date_visited asc))::INTEGER as cont_date
    from t1),

t3 as
    (select user_id, cont_date, COUNT(*) as freq
    from t2
    group by user_id, cont_date)

select user_id, 
    longest_streak
from
    (select user_id, 
        MAX(freq) as longest_streak,
        DENSE_RANK() OVER(order by MAX(freq) desc) as ranking
    from t3
    group by user_id) b
where ranking <=3
order by longest_streak desc;