with t1 as
    (select d1.origin,
        d2.destination,
        d1.cost + d2.cost as cost
    from da_flights d1
    inner join da_flights d2
    on d1.destination = d2.origin),

t2 as 
    (select origin,
        destination,
        cost
    from da_flights)

select origin,
    destination,
    MIN(cost) as min_cost
from
    (select * from t1
    union
    select * from t2) b
group by origin, destination;