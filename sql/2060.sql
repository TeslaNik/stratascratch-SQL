with dept_size as
    (select department_id,
        COUNT(id) AS size
    from az_employees
    group by department_id),

largest_depts as
    (select department_id
    from dept_size
    where size in (select max(size) from dept_size))


select first_name,
    last_name
from az_employees
where department_id in (select department_id from largest_depts)
    and lower(position) like '%manager%';