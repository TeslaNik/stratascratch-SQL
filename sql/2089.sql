WITH t1 as
    (select generate_series(0,(select MAX(page_number) from cookbook_titles),2) as left_page_number)

SELECT t1.left_page_number,
    c1.title as left_title,
    c2.title as right_title
from t1
left join cookbook_titles c1
on t1.left_page_number = c1.page_number
left join cookbook_titles c2
on t1.left_page_number = c2.page_number - 1;