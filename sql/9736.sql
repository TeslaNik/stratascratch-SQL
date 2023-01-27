WITH violations as
    (select business_id, 
        COUNT(*) AS num_violations 
    from sf_restaurant_health_violations
    where lower(risk_category) like '%high risk%' 
    group by business_id
    order by num_violations desc),

max_violations as
    (SELECT business_id from violations
    where num_violations in (select max(num_violations) from violations))

select sf.*
from sf_restaurant_health_violations sf
where sf.business_id in (select business_id from max_violations);