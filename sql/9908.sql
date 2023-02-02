select * 
from
    (select city,
        COUNT(distinct c.id) as num_customers,
        COUNT(o.id) as num_orders,
        SUM(o.total_order_cost) as total_cost_of_orders
    from customers c
    left join orders o
    on c.id = o.cust_id
    group by c.city) b
where num_orders >=5;