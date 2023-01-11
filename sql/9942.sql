with t1 as
    (select games,
        count(distinct id) as counts
    from olympics_athletes_events
    group by games)

select * 
from t1 
where counts in (select max(counts) from t1);