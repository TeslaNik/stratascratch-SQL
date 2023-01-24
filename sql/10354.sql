select company,
    profits
from 
    (select company,
        profits, 
        rank() over(order by profits desc) as ranking
    from forbes_global_2010_2014) t1
where ranking <=3;