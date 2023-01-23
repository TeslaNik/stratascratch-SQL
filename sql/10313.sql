with t1 as
    (select extract (month from request_date) as mth,
        sum(distance_to_travel)/sum(monetary_cost) as dpd
    from uber_request_logs
    group by extract(month from request_date))

select round(sqrt(avg(SE))::NUMERIC,2) AS RMSE
from (select mth,
        (dpd - lag(dpd) over(order by mth asc))^2 as SE
    from t1) t2;