select first_name,
    order_details,
    total_order_cost*1.0/SUM(total_order_cost) OVER(PARTITION BY cust_id) as perc_total
from orders o
inner join customers c
on o.cust_id = c.id;