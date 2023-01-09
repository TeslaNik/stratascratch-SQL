select f1.type,
    SUM(processed) as processed_comp,
    COUNT(f1.type) - SUM(processed) as non_processed_comp
FROM
    (select type,
    processed::integer
    from facebook_complaints) f1
group by f1.type;