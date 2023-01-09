select s.seat_left,
    s.seat_number
from theater_seatmap s
inner join theater_availability a1
on s.seat_left = a1.seat_number
inner join theater_availability a2
on s.seat_number = a2.seat_number
where a1.is_available = TRUE 
    and a2.is_available = TRUE;