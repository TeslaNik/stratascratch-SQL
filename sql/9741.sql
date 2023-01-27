WITH t1 AS
    (select business_name, 
        inspection_score,
        ROW_NUMBER() over(partition by business_id ORDER BY inspection_score DESC) - ROW_NUMBER() over(partition by business_id ORDER BY inspection_score ASC) as rank_diff
    from sf_restaurant_health_violations
    WHERE inspection_score is not null
    order by business_name)

select business_name,
    AVG(inspection_score) as median_score
from t1
where rank_diff in (-1,0,1)
GROUP BY business_name
ORDER BY median_score DESC;