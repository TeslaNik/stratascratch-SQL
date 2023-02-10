with valid_accounts as
    (select account_id
    from cvs_claims
    WHERE EXTRACT(YEAR FROM date_submitted) = 2021
    group by account_id
    HAVING COUNT(claim_id) >1)

select gender,
    ROUND(AVG(age)) as avg_age
from cvs_accounts
where account_id in (select account_id from valid_accounts)
group by gender;