select first_name,
    target,
    bonus
from employee
WHERE target in (select max(target) from employee);