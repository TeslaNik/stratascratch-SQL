select COUNT(user_id) AS num_users
from
    (select user_id,
        employer,
        LEAD(employer) over(partition by user_id order by start_date desc) as next_employer
    from linkedin_users) b
where employer = 'Microsoft' 
    AND next_employer = 'Google';