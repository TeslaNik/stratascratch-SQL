with t1 as 
    (select company,
        continent,
        profits
    from forbes_global_2010_2014
    where sector = 'Financials')

select company,
    continent
from t1
where profits in (select max(profits) from t1);