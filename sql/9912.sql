select o.cust_id,
    c.first_name,
    MIN(total_order_cost) as lowest_order_price
from orders o
inner join customers c
on o.cust_id = c.id
group by o.cust_id, c.first_name;