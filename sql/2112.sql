with q4sales as
    (SELECT * FROM fct_customer_sales where order_date between '2021-10-01' and '2021-12-31'),

orders as
    (select q.order_id,
        mct.territory_id,
        dp.prod_brand
    from q4sales q
    inner join map_customer_territory mct
    on mct.cust_id = q.cust_id
    inner join dim_product dp
    on dp.prod_sku_id = q.prod_sku_id)


select territory_id,
    prod_brand,
    --count(*) AS sales,
    count(order_id)*100.0/SUM(COUNT(order_id)) OVER(PARTITION BY territory_id) as perc_market_share
from orders
group by territory_id, prod_brand;