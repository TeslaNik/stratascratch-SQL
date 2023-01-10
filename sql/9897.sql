select department,
    first_name,
    salary
from
    (select department,
        first_name,
        salary,
        rank() over(partition by department order by salary desc) as ranking
    from employee) t1
    where t1.ranking = 1;