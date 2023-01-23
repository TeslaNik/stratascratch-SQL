with t1 as
    (select search_id,
        (case when clicked = 0 then 1
            when clicked = 1 and search_results_position >3 then 2
            when clicked = 1 and search_results_position <=3 then 3
        end) as rating
    from fb_search_events)

select search_id,
    max(rating) as max_ratings
from t1
group by search_id
order by search_id;