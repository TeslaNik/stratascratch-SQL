select cust_id,
    sum(total_order_cost) as total_revenue
from orders
where order_date BETWEEN '2019-03-01' AND '2019-03-31'
group by cust_id;