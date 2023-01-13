select jobtitle,
    percentile_cont(0.5) within group (order by totalpay) as median_salary
from sf_public_salaries
group by jobtitle
order by median_salary desc;