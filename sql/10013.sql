select advertising_channel,
    MAX(money_spent) as max_spent
from uber_advertising
where customers_acquired > 1500
group by advertising_channel
order by max_spent limit 1;