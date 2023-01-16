with t1 as
    (select country,
        sum(points) as total_points
    from winemag_p1
    group by country
    order by total_points desc limit 1)

select * 
from winemag_p1
where country in (select country from t1);