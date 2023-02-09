with recent_submissions as
    (select id, user_id
    from
        (select id, 
            user_id, 
            ROW_NUMBER() over(partition by user_id ORDER BY created_at DESC) as recency
        from loans
        where type = 'Refinance') b 
    where recency = 1)

select r.user_id,
s.balance
from recent_submissions r
inner join submissions s 
on r.id = s.loan_id;