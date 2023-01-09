WITH t1 AS
    (SELECT order_timestamp::date as order_date,
        merchant_id,
        total_amount_earned
    FROM doordash_orders),
    
t2 as
    (SELECT order_date,
        merchant_id,
        ROUND(CAST(SUM(total_amount_earned) AS NUMERIC),2) as amt,
        RANK() OVER(partition by order_date ORDER BY SUM(total_amount_earned) DESC) AS ranking
    FROM t1
    group by order_date, merchant_id),
    
t3 as
    (SELECT order_date,
        merchant_id,
        amt
    from t2
    where ranking = 1)

SELECT distinct t3a.order_date as next_order_date,
    dm.name,
    t3b.amt
from t3 t3a
inner join t3 t3b
on t3a.order_date = t3b.order_date + 1
inner join doordash_merchants dm
on t3b.merchant_id = dm.id;