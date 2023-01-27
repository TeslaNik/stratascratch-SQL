with businesses as
    (select facility_name,
        pe_description,
        COUNT(*) over(partition by pe_description) as freq_pe_description
    from los_angeles_restaurant_health_inspections
    where lower(facility_name) ~ '\y(cafe|tea|juice)\y')

select facility_name
from 
    (select facility_name,
        DENSE_RANK() over(order by freq_pe_description desc) as rank_freq
    from businesses) t1
where t1.rank_freq = 3;