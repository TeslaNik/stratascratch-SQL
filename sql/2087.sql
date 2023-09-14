with t1 as
    (select s.name,
        100*avg((case when r.score < 5 then 1 else 0 end)) as perc_negative
    from instacart_reviews r
    inner join instacart_stores s
    on r.store_id = s.id
    where s.opening_date >= '2021-07-01'
    group by s.name)

select name, 
    perc_negative/(100-perc_negative) as neg_to_pos 
from t1
where perc_negative > 20;
