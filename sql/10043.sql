with t1 as
    (select variety, price from winemag_p1
    union all
    select variety, price from winemag_p2)

select variety,
    percentile_cont(0.5) within group (order by price) as median_price
from t1
group by variety;