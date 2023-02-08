with t1 as
    (select territory_id,
        COUNT(*) AS num_customers
    from map_customer_territory
    group by territory_id),

max_customer_territories as
    (select territory_id, num_customers 
    from t1
    where num_customers in (select max(num_customers) from t1))

select m1.empl_id,
    m2.num_customers
from map_employee_territory m1
inner join max_customer_territories m2
on m1.territory_id = m2.territory_id;