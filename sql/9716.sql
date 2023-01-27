with t1 as
    (SELECT owner_name,
        facility_address,
        --AVG(score),
        ROW_NUMBER() over(PARTITION BY owner_name ORDER BY AVG(score) DESC, facility_address ASC) as ranking
    FROM los_angeles_restaurant_health_inspections
    group by owner_name,
    facility_address),

top1 as
    (select owner_name, facility_address from t1 where ranking = 1),

top2 as
    (select owner_name, facility_address from t1 where ranking = 2),

top3 as
    (select owner_name, facility_address from t1 where ranking = 3)

select top1.owner_name,
    top1.facility_address as top1_facility_address,
    top2.facility_address as top2_facility_address,
    top3.facility_address as top3_facility_address
from top1
left join top2
on top1.owner_name = top2.owner_name
left join top3
on top1.owner_name = top3.owner_name;