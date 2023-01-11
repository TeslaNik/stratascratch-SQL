select MAX(salary) as uniq_max_salary
from 
    (select salary,
        count(*) as freq
    from employee
    group by salary) b
where freq = 1;