select inspection_date,
    (COUNT(violation_id) 
        - LAG(COUNT(violation_id)) OVER(ORDER BY inspection_date asc)
        ) as change_num_violations
from sf_restaurant_health_violations
group by inspection_date;