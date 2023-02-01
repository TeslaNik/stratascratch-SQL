select e1.department,
    e1.id as employee_id,
    e1.salary as employee_salary,
    e2.salary as manager_salary,
    ROUND((sum(e1.salary) OVER(PARTITION BY e1.department) -- all dept employees' salary
            - e2.salary)/ -- manager salary
            (COUNT(*) OVER(PARTITION BY e1.department)- 1)) -- num dept employees without manager included
            AS avg_dept_salary
from employee_o e1
inner join employee_o e2
on e1.manager_id = e2.id;