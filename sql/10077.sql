select e.employee_title,
    e.sex,
    AVG(e.salary + b.bonus) as avg_compensation
from sf_employee e
inner join 
(select worker_ref_id, 
    sum(bonus) as bonus 
from sf_bonus group by worker_ref_id) b
on e.id = b.worker_ref_id
group by e.sex, e.employee_title;