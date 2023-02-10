with avg_male_time as
    (select AVG(ABS(gun_time - net_time)) as male_time
    from marathon_male),

avg_female_time as
    (select AVG(ABS(gun_time - net_time)) as female_time
    from marathon_female)

select ABS(male_time - female_time) as gender_diff
from avg_male_time, avg_female_time;