with hosts as
    (select LEFT(host_since,4)::INTEGER as yr,
        COUNT(*) AS curr_hosts
    from airbnb_search_details
    group by LEFT(host_since,4)::INTEGER)

select h1.yr,
    h1.curr_hosts as curr_hosts, 
    h2.curr_hosts as prev_hosts,
    ROUND((h1.curr_hosts - h2.curr_hosts)*100.0/h2.curr_hosts) as yoy_growth
from hosts h1
left join hosts h2
on h1.yr = h2.yr + 1
order by h1.yr;