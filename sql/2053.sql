with t1 as
    (select distinct date_trunc('month',date)::DATE as first_day,
        account_id,
        user_id
    from sf_events),

t2 as
    (select user_id, 
        account_id, 
        first_day, 
        LEAD(first_day) over(partition by account_id, user_id order by first_day asc) as next_day
    from t1)

select account_id, 
    (COUNT(next_day) filter(WHERE first_day = '2020-12-01'))*100.0/(COUNT(first_day) filter(WHERE first_day = '2020-12-01')) as dec20_perc_retention,
    (COUNT(next_day) filter(WHERE first_day = '2021-01-01'))*100.0/(COUNT(first_day) filter(WHERE first_day = '2021-01-01')) as jan21_perc_retention
from t2
where first_day IN ('2021-01-01','2020-12-01')
group by account_id
order by account_id;