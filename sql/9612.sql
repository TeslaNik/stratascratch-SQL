-- UNCLEAR QUESTION

with t1 as 
(select business_name
from yelp_reviews
where review_text similar to '(%food%|%pizza%|%sandwich%|%burger%)')

select t1.business_name,
    b.address,
    b.state
from t1
left join yelp_business b
on t1.business_name = b.name;