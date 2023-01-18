select distinct p.*
from facebook_posts p
inner join facebook_reactions r
on p.post_id = r.post_id and r.reaction = 'heart';