with t1 as
    (select name,
        rating,
        id
    from nominee_filmography
    where role_type = 'Normal Acting' and rating is not null)

select name,
    avg_rating,
    rating as second_id_rating,
    abs(avg_rating - rating) as rating_diff
from
    (select name,
        AVG(rating) over(partition by name) as avg_rating,
        rank() over(partition by name order by id desc) as ranking,
        rating
    from t1) b
where b.ranking = 2;