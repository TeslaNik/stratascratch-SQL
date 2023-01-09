WITH t1 as
    (select DISTINCT DATE_TRUNC('month', trip_date)::DATE as first_month,
        driver_id
    from uber_trips
    where is_completed = TRUE),

t2 as
    (select driver_id, 
        --first_month,
        (first_month - INTERVAL '1 month' * (ROW_NUMBER() OVER(PARTITION BY driver_id ORDER BY first_month asc))::INTEGER)::DATE as date_group
    from t1
    order by driver_id, first_month)

select distinct driver_id
from t2
group by driver_id, date_group
having COUNT(*) >=2;