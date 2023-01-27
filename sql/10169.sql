select purpose, 
    total_mileage
FROM
    (select purpose,
        SUM(miles) as total_mileage,
        ROW_NUMBER() OVER(ORDER BY SUM(miles) DESC) as ranking
    from my_uber_drives
    WHERE category = 'Business' and purpose IS NOT NULL
    group by purpose) b
WHERE ranking <=3;