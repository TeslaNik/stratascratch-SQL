select rate_type,
    loan_id,
    balance,
    balance*100.0/SUM(balance) OVER(PARTITION BY rate_type) as perc_contribution
from submissions;