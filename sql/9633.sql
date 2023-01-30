with t1 as
    (select city, 
        UNNEST(string_to_array(REGEXP_REPLACE(lower(amenities),'[{}"]','','g'),',')) as amenities 
    from airbnb_search_details)

select city from
    (select city
        --,COUNT(distinct amenities) as total_unique_amenities
        ,COUNT(amenities) as total_amenities
    from t1
    group by city
    order by total_amenities DESC limit 1) b1;
