with sales as (
    select * from {{ref('stg_raw__sales')}}
),
product as (
    select * from {{ref('stg_raw__product')}}
)
joined as(
    select 
        s.orders_id,
        s.date_date,
        s.pdt_id,
        s.revenue,
        s.quantity,
        p.purchase_price,
        cast(s.quantity*p.purchase_price AS float64) as purchase_cost
        cast(revenue - (s.quantity*p.purchase_price) AS float64) as margin
    from sales s
    left joined product p on s.pdt_id = p.products_id
)
select from joined