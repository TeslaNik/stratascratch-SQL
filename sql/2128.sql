select b.book_id,
    COALESCE(SUM(b.unit_price*o.quantity),0) as total_sales
from amazon_books b
left join amazon_books_order_details o
on b.book_id = o.book_id
group by b.book_id;