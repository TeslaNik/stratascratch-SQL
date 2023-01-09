-- UNCLEAR ON WHAT IS THE AVERAGE on

select corr(EXTRACT(epoch from(delivered_to_consumer_datetime
- customer_placed_order_datetime))/60, order_total) as correl
from doordash_delivery;