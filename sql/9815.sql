with t1 as 
    (select adwords_earnings::float/n_employees AS ape
    from google_adwords_earnings
    where business_type = 'handyman' and n_employees <=10),

t2 as
    (select ape, 
        count(*) as freq
    from t1
    group by ape)

select ape 
from t2
where freq in (select max(freq) from t2);