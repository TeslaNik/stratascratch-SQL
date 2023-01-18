with t1 as
    (select * from fb_eu_energy
    union all
    select * from fb_na_energy
    union all
    select * from fb_asia_energy),

t2 as
    (select date,
        sum(consumption) as total
    from t1
    group by date)

select date,
    sum(total) over(order by date asc) as cum_sum,
    ROUND(sum(total) over(order by date asc)*100.0/(select sum(total) from t2)) as cum_perc
from t2;