with t1 as
    (select employeename,
        jobtitle,
        totalpay,
        rank() over(partition by jobtitle order by totalpay desc) as ranking,
        avg(totalpay) over(partition by jobtitle) as avgpay
    from sf_public_salaries
    where year = 2013)

select employeename
from t1
where totalpay > avgpay and ranking > 5;