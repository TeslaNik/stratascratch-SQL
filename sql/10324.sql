SELECT id, name, total_distance
FROM
    (SELECT u.id, 
        u.name,
        SUM(r.distance) as total_distance,
        ROW_NUMBER() OVER(ORDER BY SUM(r.distance) DESC) AS ranking
    FROM lyft_users u
    inner join lyft_rides_log r
    on u.id = r.user_id
    group by u.id, u.name) t1
WHERE ranking <=10
ORDER BY total_distance DESC;