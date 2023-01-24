select host_popularity_rating,
    MIN(price) as minimum_price,
    AVG(price) as average_price,
    MAX(price) as maximum_price
FROM
    (select (CASE WHEN number_of_reviews = 0 then 'New'
            WHEN number_of_reviews between 1 and 5 then 'Rising'
            WHEN number_of_reviews between 6 and 15 then 'Trending Up'
            WHEN number_of_reviews between 16 and 40 then 'Popular'
            WHEN number_of_reviews > 40 then 'Hot'
        END) as host_popularity_rating,
        price
    from airbnb_host_searches
    where number_of_reviews is not null) b
group by host_popularity_rating;