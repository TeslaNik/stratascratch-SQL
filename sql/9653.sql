select event_name,
    count(*) as counts
from playbook_events
where device = 'macbook pro'
group by event_name
order by counts desc;