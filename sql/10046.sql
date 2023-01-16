select state,
    counts
from
    (select state, 
        count(*) as counts, 
        rank() over(order by count(*) desc) as ranking
    from yelp_business
    where stars = 5
    group by state) t1
where ranking<=5
order by counts desc, state asc;