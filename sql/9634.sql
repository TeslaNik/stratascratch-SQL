select zipcode,
    AVG(REPLACE(host_response_rate,'%','')::NUMERIC) AS avg_host_response_rate
from airbnb_search_details
WHERE cleaning_fee = TRUE and length(host_response_rate) != 0
GROUP BY zipcode
order by avg_host_response_rate, zipcode;