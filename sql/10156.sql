select h.nationality, 
    count(distinct u.unit_id)
from airbnb_hosts h
inner join airbnb_units u
on h.host_id = u.host_id
where age<30 and unit_type = 'Apartment'
group by nationality;