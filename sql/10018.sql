WITH t1 as
    (select extract(days from (coalesce(end_date,now()) - start_date)) as duration,
        yearly_salary 
    from lyft_drivers)

select CORR(duration, yearly_salary) as correlation
from t1;