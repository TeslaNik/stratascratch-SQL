select business_name,
    (case 
        when lower(business_name) like '%restaurant%' then 'restaurant'
        when lower(business_name) similar to '%(cafe|café|coffee)%' then 'cafe'
        when lower(business_name) like '%school%' then 'school'
        else 'other'
    END) as class
from (select distinct business_name 
        from sf_restaurant_health_violations) b;