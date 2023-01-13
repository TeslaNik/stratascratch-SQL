with t1 as
    (select year,
        avg(height) as avg_height
    from olympics_athletes_events
    where year between 1898 and 2016
    group by year),

t2 as
    (select generate_series(1896,2016) as year)

select t2.year,
    coalesce(t1a.avg_height, 172.73) as avg_height,
    coalesce(t1b.avg_height, 172.73) as prev_avg_height,
    coalesce(t1a.avg_height, 172.73) - coalesce(t1b.avg_height, 172.73) as height_diff
from t2
left join t1 t1a
on t2.year = t1a.year
left join t1 t1b
on t2.year = t1b.year + 1;

