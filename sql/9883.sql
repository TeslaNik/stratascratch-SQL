with t1 as
    (select pclass,
        name,
        age,
        rank() over(partition by pclass order by age desc) as ranking
    from titanic
    where survived = 1 and age is not null)

select name, 
    age, 
    pclass 
from t1 
where ranking =1 
order by pclass asc;