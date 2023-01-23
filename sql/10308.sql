with t1 as 
    (select e.salary,
        d.department 
    from db_employee e
    inner join db_dept d
    on e.department_id = d.id)

select (
        (select MAX(salary) from t1 where department = 'marketing') -
        (select MAX(salary) from t1 where department = 'engineering')
        ) as salary_difference;