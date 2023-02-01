with first_day_purchases as
    (select user_id, 
        created_at as first_day, 
        product_id as initial_product_id
    from marketing_campaign
    where (user_id, created_at) in (select user_id, MIN(created_at) from marketing_campaign group by user_id))

select COUNT(DISTINCT mc.user_id) AS num_users_after_campaign
from marketing_campaign mc
inner join first_day_purchases fdp
on mc.user_id = fdp.user_id
    and mc.created_at > fdp.first_day
where (mc.user_id, mc.product_id) not in (select user_id, initial_product_id from first_day_purchases);