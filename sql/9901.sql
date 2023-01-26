with managers as
    (select manager_id 
    FROM
        (select manager_id, 
        COUNT(id) as num_reporting
        from employee
        group by manager_id) b
    WHERE num_reporting >=7)

select first_name
from managers m
inner join employee e
on e.id = m.manager_id;