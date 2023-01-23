with t1 as 
    (select to_char(created_at,'YYYY-MM') as year_month,
        purchase_amt
    from amazon_purchases),

t2 as
    (select year_month,
        SUM(purchase_amt) as total_amt
    from t1
    group by year_month)

select year_month, 
    total_amt,
    avg(total_amt) over(order by year_month asc ROWS BETWEEN 2 preceding and current row) as rolling_amt
from t2
order by year_month;