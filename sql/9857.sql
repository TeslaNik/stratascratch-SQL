select distinct MAX(salary) as second_highest
from worker
WHERE salary < (select MAX(salary) from worker);