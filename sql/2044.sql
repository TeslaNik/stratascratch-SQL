with temp as
    (select tenure_days,
        COUNT(*) as num_emp
    from 
        (select (CURRENT_DATE - hire_date) as tenure_days
        from uber_employees
        where termination_date is null) b
    group by tenure_days),
    
lt as
    (SELECT tenure_days, num_emp from temp order by tenure_days desc limit 1),

st as
    (SELECT tenure_days, num_emp from temp order by tenure_days asc limit 1)

select lt.num_emp as longest_tenure_emps,
    st.num_emp as shortest_tenure_emps,
    (lt.tenure_days - st.tenure_days) as days_between
from lt, st;