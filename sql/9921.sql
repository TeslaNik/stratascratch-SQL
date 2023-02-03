select department,
    COUNT(id) FILTER(WHERE sex = 'F') as total_num_females,
    SUM(salary) FILTER(WHERE sex = 'F') as total_female_salary,
    COUNT(id) FILTER(WHERE sex = 'M') as total_num_males,
    SUM(salary) FILTER(WHERE sex = 'M') as total_male_salary
from employee
group by department;