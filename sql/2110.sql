with t1 as
    (select h.manager_empl_id,    
        AVG(e1.salary) as manager_salary,
        AVG(e2.salary) as avg_emp_salary
    from map_employee_hierarchy h
    inner join dim_employee e1
    on h.manager_empl_id =e1.empl_id
    inner join dim_employee e2
    on h.empl_id =e2.empl_id
    group by h.manager_empl_id)

select * from t1
where manager_salary < 2*avg_emp_salary;