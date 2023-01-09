select restaurant_id,
    revenue
from
    (select 
        restaurant_id,
        SUM(order_total) as revenue,
        CUME_DIST() over(ORDER BY SUM(order_total)) as percentile
    from doordash_delivery
    where to_char(customer_placed_order_datetime,'YYYY-MM') = '2020-05'
    group by restaurant_id) b
where percentile <=0.02;