with t1 as
(select user_id, 
    (created_at - lag(created_at) OVER(PARTITION BY user_id order by created_at asc)) as return_days
from amazon_transactions)

select user_id 
FROM
    (select user_id,
        MIN(return_days) as min_return_days
    FROM t1
    GROUP BY user_id) b
WHERE min_return_days <=7;