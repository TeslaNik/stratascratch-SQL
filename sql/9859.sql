select worker_id, first_name, last_name, salary, joining_date, department
from
(select *,
cume_dist() over(order by worker_id) as ranking
from worker) b
where ranking <=0.5;