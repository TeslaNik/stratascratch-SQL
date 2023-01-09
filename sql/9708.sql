select AVG(SE) as MSE,
    SQRT(AVG(SE)) as RMSE
from
    (select (score - AVG(score) over())^2 as SE
    from los_angeles_restaurant_health_inspections
    where grade = 'A') b;
