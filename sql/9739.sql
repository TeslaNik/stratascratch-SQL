with t1 as
    (select EXTRACT(YEAR FROM inspection_date) as yr,
        business_name,
        violation_id
    from sf_restaurant_health_violations
    where violation_id is not null)

select yr, 
    business_name, 
    num_violations
from
    (select yr, 
        business_name, 
        COUNT(violation_id) as num_violations,
        RANK() OVER(PARTITION BY yr ORDER BY COUNT(violation_id) desc) AS ranking
    FROM t1
    GROUP BY yr, business_name) b
where ranking = 1
order by yr;