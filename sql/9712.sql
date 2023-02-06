select MAX(activity_date) AS last_time,
    MIN(activity_date) AS first_time
from los_angeles_restaurant_health_inspections
WHERE score in (select MAX(score) from los_angeles_restaurant_health_inspections);