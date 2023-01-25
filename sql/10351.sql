select from_user,
COUNT(id) as num_emails,
ROW_NUMBER() OVER(ORDER BY COUNT(id) DESC, from_user ASC) as ranking
from google_gmail_emails
group by from_user;