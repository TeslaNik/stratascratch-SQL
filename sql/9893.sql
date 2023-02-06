select cust_id
from
    (select cust_id,
        COUNT(id) as num_orders
    from orders
    group by cust_id) b
where num_orders > 3;