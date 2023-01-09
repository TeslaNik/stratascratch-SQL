select f.type,
    avg(f.processed::INTEGER) as processing_rate
from facebook_complaints f
group by f.type;