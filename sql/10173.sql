with t1 as
    (select trackname, artist, date, LEAD(date) over(order by date) as until,
        LEAD(date) over(order by date) -date as diff
    from spotify_daily_rankings_2017_us),
    
    t2 as
    (select * from
        (select trackname, 
            artist, date, LEAD(date) over(order by date) as until,
            LEAD(date) over(order by date) -date as diff,
            region
        from spotify_worldwide_daily_song_ranking
        where position = 1) b
    where region = 'us'),
    
    t11 as
    (select trackname, 
        artist, -- date, until, diff,
        date + generate_series(0,diff-1) as individual_dates from t1),
    
    t22 as
    (select trackname, 
        artist, -- date, until, diff,
        date + generate_series(0,diff-1) as individual_dates from t2)

select t11.trackname,
    t11.artist, 
    COUNT(t11.individual_dates) as days_as_position1_both_us_and_world
from t11
inner join t22
on t11.trackname = t22.trackname and t11.artist = t22.artist and t11.individual_dates = t22.individual_dates
GROUP BY t11.trackname, t11.artist
order by t11.trackname;