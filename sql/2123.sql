WITH t1 as
    (select p.product_family,
        COALESCE(s.units_sold,0) as units_sold,
        (case when s.promotion_id in (SELECT promotion_id from facebook_sales_promotions) THEN 1 else 0 END) AS valid_promotion
    from facebook_products p
    left join facebook_sales s
    on s.product_id = p.product_id)

SELECT product_family,
    SUM(units_sold) as total_sold,
    COALESCE(SUM(CASE WHEN valid_promotion = 1 then units_sold else 0 end)*100.0/NULLIF(SUM(units_sold),0),0) as perc_sold_promo
from t1
group by product_family;