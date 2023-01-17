with t1 as
    (select date, consumption from fb_eu_energy
    union all
    select date, consumption from fb_asia_energy
    union all
    select date, consumption from fb_na_energy),

t2 as
    (select date, 
        sum(consumption) as total
    from t1
    group by date)

select * from t2 
where t2.total in (select max(total) from t2)