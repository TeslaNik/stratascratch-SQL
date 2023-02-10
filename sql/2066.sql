SELECT hometown, 
    avg_net_time
from
    (select hometown,
        avg(net_time) as avg_net_time,
        DENSE_RANK() OVER(ORDER BY avg(net_time) ASC) as speed_ranking
    from marathon_male
    group by hometown) b
WHERE speed_ranking <=3;