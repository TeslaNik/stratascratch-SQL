with december_transactions as
    (select transaction_id,
        time_stamp::DATE as date,
        time_stamp::TIME as time,
        EXTRACT(isodow FROM time_stamp) as dow -- isodow: Monday - 1 to Sunday - 7
    from boi_transactions
    WHERE to_char(time_stamp, 'yyyy-mm') = '2022-12'),

transaction_validity as
    (select transaction_id,
        (CASE WHEN date in ('2022-12-25','2022-12-26') then 0
            WHEN (dow between 1 and 5) and (time between '09:00:00' and '16:00:00') then 1
            ELSE 0
        END) AS validity
    from december_transactions)

select transaction_id
from transaction_validity
where validity = 0;