with t1 as
    (select jobtitle,
        SUM(CASE WHEN benefits >0 then 0 else 1 END) as emp_benefits,
        COUNT(*) as total_emp
    from sf_public_salaries
    group by jobtitle)

select jobtitle,
    emp_benefits,
    total_emp,
    emp_benefits*1.0/total_emp as ratio
from t1
order by ratio asc;