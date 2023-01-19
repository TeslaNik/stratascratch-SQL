select top_genre
from nominee_information
where name in
(select nominee 
    from
        (select nominee,
            RANK() OVER(ORDER BY SUM(winner::INTEGER) DESC, nominee ASC) as ranking
        from oscar_nominees
        group by nominee) b
    where ranking =1)