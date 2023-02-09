with orders_20_21 as
    (select * 
    from
        (select user_id,
            EXTRACT(YEAR FROM order_date) as yr
        from amazon_orders) b1
    where yr in (2020,2021))


SELECT user_id
from
    (select user_id, yr    
    from orders_20_21
    group by user_id, yr
    having COUNT(*) >=3) at_least_3_orders
group by user_id
having COUNT(yr) = 2;