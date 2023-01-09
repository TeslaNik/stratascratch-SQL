with t1 as
    (select player_id,
        ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY login_date asc) AS rownum,
        login_date,
        LEAD(login_date) OVER(PARTITION BY player_id ORDER BY login_date asc) as next_login_date
    from players_logins),

t2 as
    (select player_id,
        next_login_date - login_date as num_days_diff
    from t1
    where rownum = 1)

select COUNT(player_id) FILTER(WHERE num_days_diff = 1)*1.0/COUNT(player_id) as first_day_retention_rate
from t2;