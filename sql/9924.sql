select distinct home_library_code
from library_usage
WHERE provided_email_address != TRUE 
and notice_preference_definition = 'email'
and circulation_active_year = 2016;