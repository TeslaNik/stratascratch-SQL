with t1 as
    (select day, 
        count(session_id) as e_counts,
        avg(count(session_id)) over() as avg_e_counts
    from google_fit_location
    group by day),

t2 as
    (select day, 
        count(id) as r_counts,
        avg(count(id)) over() as avg_r_counts
    from google_gmail_emails
    group by day),

t3 as
    (select t1.day,
        t1.e_counts,
        t1.avg_e_counts,
        t2.r_counts,
        t2.avg_r_counts
    from t1
    inner join t2
    on t1.day = t2.day)

select 
--corr(e_counts, r_counts) as sql_corr,
sum((e_counts-avg_e_counts)*(r_counts-avg_r_counts))/(sum((e_counts-avg_e_counts)^2)*sum((r_counts-avg_r_counts)^2))^0.5 as correlation
from t3;