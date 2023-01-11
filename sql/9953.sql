select games,
    SUM(CASE WHEN sex = 'M' then 1 else 0 end) as male,
    SUM(CASE WHEN sex = 'F' then 1 else 0 end) as female,
    SUM(CASE WHEN sex = 'M' then 1 else 0 end)*1.0/NULLIF(SUM(CASE WHEN sex = 'F' then 1 else 0 end),0) as gender_ratio
from olympics_athletes_events
group by games
order by games;