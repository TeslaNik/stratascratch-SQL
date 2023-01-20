with t1 as
    (select to_char(request_date,'YYYY-MM') as date,
        abs(distance_to_travel/monetary_cost - avg(distance_to_travel/monetary_cost) over(partition by to_char(request_date,'YYYY-MM'))) as abs_diff
    from uber_request_logs)

select date,
    ROUND(avg(abs_diff)::NUMERIC,2) as abs_avg_diff
from t1
group by date
order by date;