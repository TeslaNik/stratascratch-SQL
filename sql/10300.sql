with t1 as
    (select md.date,
        md.downloads,
        ma.paying_customer
    from ms_download_facts md
    inner join ms_user_dimension mu
    on md.user_id = mu.user_id
    inner join ms_acc_dimension ma
    on mu.acc_id = ma.acc_id),

t2 as
    (select date,
        sum(case when paying_customer = 'no' then downloads else 0 end) as nonpaying_downloads,
        sum(case when paying_customer = 'yes' then downloads else 0 end) as paying_downloads
    from t1
    group by date)

select * 
from t2
where nonpaying_downloads > paying_downloads
order by date;