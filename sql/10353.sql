select t.worker_title 
from worker w
inner join title t
on t.worker_ref_id = w.worker_id
where w.salary in (select max(salary) from worker);