with highest_daily_order as
    (select cust_id,
        order_date,
        SUM(total_order_cost) as daily_cost
    from orders
    where order_date BETWEEN '2019-02-01' and '2019-05-01'
    group by cust_id, order_date
    order by daily_cost desc limit 1)

select first_name,
    daily_cost,
    order_date
from highest_daily_order h
inner join customers c
on h.cust_id = c.id;