select department,
    percentile_cont(0.5) within group (order by salary) as median_salary
from employee
group by department;