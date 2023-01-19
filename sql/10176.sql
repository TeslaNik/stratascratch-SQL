select bike_number,
    max(end_time) as return_time
from dc_bikeshare_q1_2012
group by bike_number
order by return_time desc;