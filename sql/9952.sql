with t1 as
    (select LENGTH(regexp_replace(lower(name),'[^a-z]+','','g')) as num_letters,
        medal
    from olympics_athletes_events)

select num_letters,
    SUM(case when medal is null then 1 else 0 end) as no_medals,
    SUM(case when medal = 'Bronze' then 1 else 0 end) as bronze_medals,
    SUM(case when medal = 'Silver' then 1 else 0 end) as silver_medals,
    SUM(case when medal = 'Gold' then 1 else 0 end) as gold_medals
from t1
group by num_letters
order by num_letters;