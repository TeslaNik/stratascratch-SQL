with t1 as
    (select qb,
        substring(lg,'[0-9]+')::INTEGER as lg_num
    from qbstats_2015_2016
    where year = 2016)

select qb, 
    lg_num
from t1
where lg_num in (select MAX(lg_num) from t1);