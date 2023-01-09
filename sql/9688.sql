select activity_date
    --, FACILITY_NAME
    , pe_description
from los_angeles_restaurant_health_inspections
where score <95 and facility_name like '%STREET CHURROS%';