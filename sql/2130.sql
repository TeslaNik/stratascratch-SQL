with t1 as
    (select u_id, training_id, training_date, freq
    FROM
        (select u_id, training_id, training_date,
            COUNT(*) AS freq
        from training_details
        group by u_id, training_id, training_date) b
    WHERE freq >1)
    

select ut.u_name,
    t1.training_id,
    t1.training_date, 
    t1.freq
from t1
inner join users_training ut
on t1.u_id = ut.u_id;