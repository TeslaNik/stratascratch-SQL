-- UNCLEAR QUESTION

with t1 as
    (select feature_id,
        user_id,
        step_reached,
        LEAD(timestamp) OVER(partition by feature_id, user_id order by step_reached asc) - timestamp
    as timestamp_diff
    from facebook_product_features_realizations)

select feature_id,
    AVG(avg_td) as avg_btw_steps
from
    (select feature_id,
        step_reached,
        AVG(timestamp_diff) as avg_td
    from t1
    where timestamp_diff is not null
    group by feature_id, step_reached) t2
group by feature_id;