select has_bonus,
    COUNT(id) as num_employees
from
(select distinct e.id,
        CASE WHEN b.worker_ref_id is null then 0 else 1 end as has_bonus
    from employee e
    left join bonus b
    on e.id = b.worker_ref_id) b
group by has_bonus;