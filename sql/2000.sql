select loan_id,
    CASE WHEN rate_type = 'variable' THEN 1 ELSE 0 END AS variable_type,
    CASE WHEN rate_type = 'fixed' THEN 1 ELSE 0 END AS fixed_type
from submissions;