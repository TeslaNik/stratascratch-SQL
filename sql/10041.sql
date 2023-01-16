with t1 as
    (select price, 
        region_1 as region, 
        variety
    from winemag_p1 where region_1 is not null
    union all
    select price, 
        region_2, 
        variety
    from winemag_p1 where region_2 is not null),

t2 as
    (select region,
        variety, 
        price,
        rank() over(partition by region order by price desc) as expensive,
        rank() over(partition by region order by price asc) as cheapest
    from t1)

select region,
    MAX(case when expensive = 1 then variety end) as expensive_wine,
    MAX(case when cheapest = 1 then variety end) as cheapest_wine
from t2
group by region
order by region;
