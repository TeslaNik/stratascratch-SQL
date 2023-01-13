select distinct name
from olympics_athletes_events
where sport = 'Alpine Skiing' 
and noc = 'NOR' 
and year = 1992
and name not in (select distinct name
                        from olympics_athletes_events
                        where sport = 'Alpine Skiing' 
                        and noc = 'NOR' 
                        and year = 1994);