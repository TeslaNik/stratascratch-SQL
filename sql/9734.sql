with t1 as
    (select extract(YEAR from inspection_date) as yr,
        extract(MONTH from inspection_date) as mth,
        inspection_id
    from sf_restaurant_health_violations
    where business_postal_code = 94102),

years as
    (select distinct EXTRACT(YEAR FROM inspection_date) as yr
    FROM sf_restaurant_health_violations)

select years.yr,
    sum(CASE WHEN mth = 1 THEN 1 ELSE 0 END)as Insp_January,
    sum(CASE WHEN mth = 5 THEN 1 ELSE 0 END)as Insp_May,
    sum(CASE WHEN mth = 11 THEN 1 ELSE 0 END)as Insp_November
FROM years
left join t1
on t1.yr = years.yr
GROUP BY years.yr;