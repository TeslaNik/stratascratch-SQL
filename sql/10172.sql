with invoices as
    (select description,
        extract(month from invoicedate) as invoice_month,
        sum(unitprice*quantity) as total_invoice
    from online_retail
    group by description, extract(month from invoicedate)
    order by invoice_month, total_invoice desc),

rankings as
    (select *,
        rank() over(partition by invoice_month order by total_invoice desc) as ranking
    from invoices)

select invoice_month,
    description,
    total_invoice
from rankings
where ranking = 1;