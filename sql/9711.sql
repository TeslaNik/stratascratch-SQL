WITH inspections as
    (select facility_name,
        EXTRACT(YEAR FROM activity_date) as yr,
        RANK() OVER(PARTITION BY facility_name ORDER BY COUNT(*) DESC) as ranking
    from los_angeles_restaurant_health_inspections
    group by facility_name, EXTRACT(YEAR FROM activity_date)),

rank1 as
    (select *,
        COUNT(ranking) OVER(PARTITION BY facility_name) as num_rank1
    from inspections 
    where ranking = 1)

select facility_name 
from rank1
where num_rank1 = 1 and yr = 2017;