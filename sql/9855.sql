select salary as fifth_highest_salary
from
    (select salary,
        dense_rank() over(order by salary desc) as ranking
    from worker) b
where ranking = 5;