with temp as
    (select employee_id,
        popularity,
        row_number() over(order by popularity desc, employee_id asc) as ranking,
        count(*) over() as total_emp
    from facebook_hack_survey)

select t1.employee_id as fan,
    t2.employee_id as opp
from temp t1
inner join temp t2
on t1.ranking = (t1.total_emp+1) - t2.ranking 
    and t1.employee_id != t2.employee_id;