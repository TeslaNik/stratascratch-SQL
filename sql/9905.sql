with t1 as
    (select first_name,
        target
    from salesforce_employees
    where manager_id = 13)

select * from t1
where target in (select max(target) from t1);