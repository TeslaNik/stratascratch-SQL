select employeename,
    jobtitle,
    totalpaybenefits
    --,top5l
from
    (select employeename,
        jobtitle,
        totalpaybenefits,
        dense_rank() over(partition by jobtitle order by totalpaybenefits asc) as top5l
    from sf_public_salaries) b
where top5l <=5;