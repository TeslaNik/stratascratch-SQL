with t1 as
    (select title,
        (regexp_match(title,'(\d{4})'))[1]::NUMERIC as year,
        points
    from winemag_p2),

t2 as
    (select year,
        avg(points) as avg_points
    from t1
    where year is not null
    group by year),

t3 as
    (select generate_series(2000,(select max(year) from t2)) as year)

select t3.year,
    COALESCE(t2a.avg_points,87) as avg_points,
    COALESCE(t2b.avg_points,87) as prev_avg_points,
    (COALESCE(t2a.avg_points,87) - COALESCE(t2b.avg_points,87)) as points_diff
from t3
left join t2 t2a
on t2a.year = t3.year
left join t2 t2b
on t2b.year = t3.year-1;