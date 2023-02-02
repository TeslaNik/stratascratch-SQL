select city
from
    (select distinct city,
        AVG(mkt_price) OVER(PARTITION BY city) as avg_city_price,
        AVG(mkt_price) OVER() AS avg_national_price
    from zillow_transactions) b
where avg_city_price > avg_national_price;