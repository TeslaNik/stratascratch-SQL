with t1 as
    (select 
        country,
        winery,
        avg(points) as avg_points
    from winemag_p1
    group by country, winery),

t2 as 
    (select * 
    from
        (select country,
            concat(winery,' (',avg_points::int,')') as winery_avg_points,
            row_number() over(partition by country order by avg_points desc, winery asc) as ranking
        from t1) t3
    where ranking <=3),

best as
    (select country, winery_avg_points from t2 where ranking = 1),

second_best as
    (select country, winery_avg_points from t2 where ranking = 2),

third_best as
    (select country, winery_avg_points from t2 where ranking = 3)

select b.country,
    b.winery_avg_points as best,
    coalesce(sb.winery_avg_points, 'No second winery') as second_best,
    coalesce(tb.winery_avg_points, 'No third winery') as third_best
from best b
left join second_best sb
on b.country = sb.country
left join third_best tb
on b.country = tb.country
order by b.country; 