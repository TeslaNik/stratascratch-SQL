with violations as
    (select EXTRACT(YEAR FROM inspection_date) as yr,
        violation_id
    from sf_restaurant_health_violations
    where business_name = 'Roxanne Cafe')

select yr,
    COUNT(violation_id) as num_violations
from violations
GROUP BY yr
ORDER BY yr;