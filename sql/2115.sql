with t1 as
    (select EXTRACT(MONTH FROM order_placed_time) AS mth,
        restaurant_id,
        sales_amount
    from delivery_orders d
    inner join order_value o
    on d.delivery_id = o.delivery_id
    WHERE EXTRACT(YEAR FROM order_placed_time) = 2021),
    
t2 as
    (select mth,
        restaurant_id,
        SUM(sales_amount) as mth_amt
    from t1
    group by mth, restaurant_id
    having SUM(sales_amount) > 100
    order by mth)

select mth,
COUNT(t2.restaurant_id)*100.0/(SELECT COUNT(DISTINCT restaurant_id) from delivery_orders) as perc
from t2
group by mth
order by mth;