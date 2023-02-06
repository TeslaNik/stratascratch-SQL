with t1 as
    (select distinct owner_name,
        facility_name,
        grade
    from la_restaurant_health_inspections)

select distinct owner_name
FROM
    (select owner_name, 
        facility_name, 
        COUNT(*) AS num_grades
    from t1
    group by owner_name, facility_name) b
where num_grades = 3;