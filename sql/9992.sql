select artist,
    count(*) as counts
from spotify_worldwide_daily_song_ranking
group by artist
order by counts desc;