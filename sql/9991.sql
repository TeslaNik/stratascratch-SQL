select trackname, 
    COUNT(*) AS freq
from spotify_worldwide_daily_song_ranking
where position = 1
GROUP BY trackname
ORDER BY freq DESC;