with t1 as
    (select unnest(string_to_array(categories,';')) as category,
        review_count
    from yelp_business)

select category, 
    sum(review_count) as tot_reviews
from t1
group by category
order by tot_reviews desc;