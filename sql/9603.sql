with t1 as
(select t1.passengerid,
    t1.name,
    abs(t1.fare - t2.fare) as fare_diff
from titanic t1
cross join titanic t2
where t1.passengerid != t2.passengerid
    and t1.pclass = t2.pclass
    and t1.survived = 0 and t2.survived = 0
    and abs(t1.age - t2.age) <= 5)

select name,
    AVG(fare_diff) as avg_fare_diff
from t1
group by passengerid, name
order by avg_fare_diff desc;