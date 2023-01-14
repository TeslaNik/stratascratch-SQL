with t1 as
    (select extract(year from end_date) as curr_year,
        count(*) as curr_churn
    from lyft_drivers
    where end_date is not null
    group by curr_year),

t2 as
    (select curr_year,
        curr_churn,
        lag(curr_churn) over(order by curr_year asc) as prev_churn
    from t1)

select *,
    (case when curr_churn > prev_churn then 'increase'
        when curr_churn < prev_churn then 'decrease'
        else 'no change' 
    end) as status
from t2;