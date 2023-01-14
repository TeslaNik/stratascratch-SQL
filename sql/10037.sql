select taster_name,
    variety
from
    (select taster_name,
        variety,
        rank() over(partition by taster_name order by count(*) desc) as ranking
    from winemag_p2
    where taster_name is not null
    group by taster_name, variety) b
where ranking = 1
order by taster_name;