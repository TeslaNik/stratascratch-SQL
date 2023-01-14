select weather,
    hour,
    count(*)*100.0/((select count(*) as total from lyft_rides)) as perc_freq
from lyft_rides
group by weather, hour
order by weather, hour;