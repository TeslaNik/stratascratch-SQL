with q3sales as
    (SELECT cust_id, order_value FROM fct_customer_sales where order_date between '2021-07-01' and '2021-09-30'),

q4sales as
    (SELECT cust_id, order_value FROM fct_customer_sales where order_date between '2021-10-01' and '2021-12-31')


select territory_id,
    (q4_total_value - q3_total_value)*100.0/q3_total_value as sales_growth
FROM
    (select mct.territory_id, 
        SUM(q3.order_value) as q3_total_value,
        SUM(q4.order_value) as q4_total_value
    from map_customer_territory mct
    inner join q3sales q3
    on q3.cust_id = mct.cust_id
    inner join q4sales q4
    on q4.cust_id = mct.cust_id
    GROUP BY mct.territory_id) quarter_wise_orders;