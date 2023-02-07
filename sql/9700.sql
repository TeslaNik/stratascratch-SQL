with t1 as
    (select grade, 
        MAX(score) AS highest_score,
        MIN(score) AS lowest_score
    from los_angeles_restaurant_health_inspections
    group by grade),

bounds as
    (select grade, 
        lowest_score,
        highest_score AS upper_bound,
        COALESCE(LAG(highest_score) OVER(ORDER BY highest_score ASC), lowest_score-1) as lower_bound
    from t1)

select grade, 
    upper_bound as highest_score,
    lowest_score,
    CONCAT('Score > ',lower_bound, ' AND Score <= ',upper_bound, ' => Grade = ',grade) as rule
from bounds
order by grade asc;