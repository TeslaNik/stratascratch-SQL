with t1 as
    (select to_char(created_at,'YYYY-MM') as yr_mth, 
        SUM(value) as monthly_revenue
    from sf_transactions
    group by to_char(created_at,'YYYY-MM'))

select yr_mth,
    --monthly_revenue,
    ROUND((monthly_revenue - LAG(monthly_revenue) OVER(ORDER BY yr_mth ASC))*100.0/monthly_revenue,2) as perc_change
from t1
ORDER BY yr_mth;