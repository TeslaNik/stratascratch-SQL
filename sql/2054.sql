WITH t1 as (
    select user_id,
        date - (
            row_number() over(
                partition by user_id
                order by date
            )
        )::integer as date_group
    from sf_events
    order by user_id,
        date
)
select distinct user_id
from (
        select user_id,
            date_group,
            COUNT(*) AS freq
        from t1
        group by user_id,
            date_group
    ) b
where freq >= 3;