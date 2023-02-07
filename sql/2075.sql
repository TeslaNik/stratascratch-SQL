with t1 as
    (select student_id,
        AVG(grade) as avg_grade,
        COUNT(grade)*100.0/COUNT(homework_id) as completion_rate
    from allstate_homework
    group by student_id)

select s.student_firstname,
    t1.avg_grade,
    t1.completion_rate
from t1
inner join allstate_students s
on t1.student_id = s.student_id;