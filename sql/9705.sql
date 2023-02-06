select count(*) AS num_inspections
from los_angeles_restaurant_health_inspections
WHERE EXTRACT(YEAR FROM activity_date) = 2017 
    and LOWER(pe_description) like '%low risk%';