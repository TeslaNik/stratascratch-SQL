with t1 as
    (select event,
        team,
        medal
    from olympics_athletes_events
    where city ilike '%rio%' AND year = 2016),

t2 as
    (select event,
        team,
        COUNT(medal) as num_medals,
        ROW_NUMBER() over(partition by event order by COUNT(medal) desc, team asc) as ranking
    from t1
    where medal is not null
    group by event, team),

t3 as 
    (select distinct event from t1)

select t3.event,
    (CASE WHEN t2a.team is not null THEN CONCAT(t2a.team, ' with ',t2a.num_medals,' medal(s)') else 'No Team' END) as gold_team,
    (CASE WHEN t2b.team is not null THEN CONCAT(t2b.team, ' with ',t2b.num_medals,' medal(s)') else 'No Team' END) as silver_team,
    (CASE WHEN t2c.team is not null THEN CONCAT(t2c.team, ' with ',t2c.num_medals,' medal(s)') else 'No Team' END) as bronze_team
from t3
left join (select * from t2 where ranking = 1) t2a
on t3.event = t2a.event
left join (select * from t2 where ranking = 2) t2b
on t3.event = t2b.event
left join (select * from t2 where ranking = 3) t2c
on t3.event = t2c.event
order by t3.event;