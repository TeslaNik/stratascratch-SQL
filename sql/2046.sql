with t1 as
    (select id, 
        hire_date, 
        coalesce(termination_date, CURRENT_DATE) AS termination_date
    from uber_employees),

hire_dates as
    (select distinct hire_date from t1),

concurrent_emps as
    (select hd.hire_date,
        COUNT(distinct id) as concurrent_emp
    from hire_dates hd
    inner join t1
    on hd.hire_date >= t1.hire_date 
        and hd.hire_date < t1.termination_date
    group by hd.hire_date),

points_in_time as
    (select t1.id,
        ce.concurrent_emp,
        ce.hire_date as point_in_time
    from t1
    inner join concurrent_emps ce
    on t1.hire_date>= ce.hire_date 
        and t1.termination_date > ce.hire_date
    order by id, t1.hire_date),

max_concurrent_emps as
    (select id,
        MAX(concurrent_emp) as max_concurrent_emp
    from points_in_time 
    group by id)

select mce.id, 
    mce.max_concurrent_emp, 
    MIN(pit.point_in_time) as first_max_date
from max_concurrent_emps mce
inner join points_in_time pit
on mce.id = pit.id 
    and mce.max_concurrent_emp = pit.concurrent_emp
group by mce.id, mce.max_concurrent_emp
order by mce.id;