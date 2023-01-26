select company_name,
    (COUNT(product_name) FILTER(WHERE year = 2020) -
    COUNT(product_name) FILTER(WHERE year = 2019)) as net_diff_2020
from car_launches
group by company_name;