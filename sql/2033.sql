select *,
    avg_amt/avg_duration as a_d_ratio
from
    (select s.location,
        AVG(t.amt) as avg_amt,
        AVG(signup_stop_date - signup_start_date) as avg_duration
    from signups s
    inner join transactions t
    on s.signup_id = t.signup_id
    group by s.location) b
order by a_d_ratio desc;