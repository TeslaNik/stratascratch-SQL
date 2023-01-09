with t1 as
    (select player_id,
        ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY match_date ASC) as match_num,
        match_result
    from players_results),

t2 as
    (select player_id,
        match_num - ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY match_num ASC) AS match_group
    from t1
    where match_result = 'W'),

t3 as
    (select player_id, 
        match_group, 
        count(*) as streak
    from t2
    group by player_id, match_group)

select distinct player_id, streak
from t3
where streak in (select max(streak) from t3);