select first_name
from customers
where id not in (select cust_id from orders);