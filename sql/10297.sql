with t1 as
    (select fu.id,
        count(fc.body) as num_comments
    from fb_comments fc
    inner join fb_users fu
    on fu.id = fc.user_id
    where fc.created_at >='2020-01-01' 
        and fc.created_at < '2020-02-01' 
        and extract(year from fu.joined_at) between 2018 and 2020
        and fc.created_at >= fu.joined_at
    group by fu.id),

t2 as
    (select num_comments,
        count(*) as num_users
    from t1
    group by num_comments)

select * from t2
order by num_comments;