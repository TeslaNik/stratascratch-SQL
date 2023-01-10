with t1 as
    (select MAX(salary) as salary,
        department
    from worker
    group by department)

select department,
    first_name,
    salary
from worker
where (salary, department) in (select salary, department from t1);