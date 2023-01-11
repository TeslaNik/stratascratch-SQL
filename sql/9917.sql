select department,
    first_name,
    salary,
    avg(salary) over(partition by department) as avg_salary
from employee;