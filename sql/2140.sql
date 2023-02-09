with rank3 as
    (SELECT cust_id 
    FROM
        (select cust_id,
            DENSE_RANK() OVER(ORDER BY SUM(total_order_cost) DESC) AS ranking
        from card_orders
        GROUP BY cust_id) b
    where ranking = 3)

select id, 
    first_name, 
    last_name
from customers
where id in (select cust_id from rank3);