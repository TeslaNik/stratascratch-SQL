select m1.title,
    ROUND(m1.budget*1.0/COUNT(m2.emp_id)) as budget_per_emp
from ms_projects m1
INNER join ms_emp_projects m2
on m1.id = m2.project_id
group by m1.title, m1.budget
order by budget_per_emp desc;