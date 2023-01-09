with t1 as
    (select distinct *,
        UNNEST(string_to_array(filter_room_types,',')) as rooms
    from airbnb_searches)

select rooms,
    count(*) as number_of_searches
from t1
where length(rooms)>0
group by rooms;