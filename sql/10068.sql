select e.to_user,
    COUNT(email_id) FILTER(WHERE label = 'Promotion') as promotion_emails,
    COUNT(email_id) FILTER(WHERE label = 'Social') as social_emails,
    COUNT(email_id) FILTER(WHERE label = 'Shopping') as shopping_emails
from google_gmail_emails e
inner join google_gmail_labels l
on e.id = l.email_id
group by e.to_user
order by e.to_user;