with t1 as
    (select id, 
        name from instacart_stores
    where extract(month from opening_date) >6),
    
t2 as
    (select store_id,
        SUM(case when score <5 then 1 else 0 end) as num_neg_reviews,
        COUNT(*) as total_reviews
    from instacart_reviews
    group by store_id)

select t1.name,
    t2.num_neg_reviews*1.0/(t2.total_reviews - t2.num_neg_reviews) as neg_to_pos_ratio
from t1
inner join t2
on t1.id = t2.store_id
where t2.num_neg_reviews*1.0/t2.total_reviews > 0.20;