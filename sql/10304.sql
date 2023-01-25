with t1 as
    (select lep.project_id, 
        SUM(le.salary) as yearly_emp_expense
    from linkedin_emp_projects lep
    inner join linkedin_employees le
    on lep.emp_id = le.id
    group by lep.project_id),

t2 as
    (select id, 
        title,
        budget,
        (end_date - start_date)*1.0/365 as project_duration_yrs
    from linkedin_projects)

select * 
from
    (select t2.title,
        t2.budget,
        CEIL(t2.project_duration_yrs*t1.yearly_emp_expense) as total_emp_expense
    from t2
    inner join t1
    on t2.id = t1.project_id) t3
where budget < total_emp_expense;