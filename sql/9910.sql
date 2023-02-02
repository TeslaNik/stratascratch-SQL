with t1 as
    (select * from 
        (select cust_id,
            COUNT(id) as num_orders,
            SUM(total_order_cost) as total_order_value
        from orders
        group by cust_id) b
    where num_orders > 3 and total_order_value >100)

select c.first_name,
    c.city,
    t1.num_orders,
    t1.total_order_value
from t1
inner join customers c 
on t1.cust_id = c.id;