SELECT distinct h.host_id,
    g.guest_id
FROM airbnb_hosts h
inner join airbnb_guests g
on h.gender = g.gender and h.nationality=g.nationality