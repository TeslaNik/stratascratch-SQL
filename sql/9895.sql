select email
FROM
    (select email,
        ROW_NUMBER() over(PARTITION by email) AS ranking
    from employee) b
WHERE ranking = 2;