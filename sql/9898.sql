with t1 as
    (select department,
        salary,
        dense_rank() over(partition by department order by salary desc) as ranking
    from twitter_employee)

select distinct department,
    salary
from t1
where ranking <=3
order by department, salary desc;