select MAX(salary) as second_highest_salary
from employee
where salary < (Select MAX(salary) from employee);