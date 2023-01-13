select employeename,
    totalpaybenefits
from
    (select employeename,
        totalpaybenefits,
        rank() over(order by totalpaybenefits desc) as top5h,
        rank() over(order by totalpaybenefits asc) as top5l
    from sf_public_salaries) b
where top5h <=5 or top5l <=5
order by totalpaybenefits;