with sales as (
    select * from {{ ref('stg_raw__sales') }}
),
product as (
    select * from {{ ref('stg_raw__product') }}
),
joined as (
    select
        s.orders_id,
        s.date_date,
        s.products_id,
        s.revenue,
        s.quantity,
        p.purchase_price,
        CAST(s.quantity * p.purchase_price AS FLOAT64) as purchased_cost,
        CAST(s.revenue - (s.quantity * p.purchase_price) AS FLOAT64) as margin
    from sales s
    left join product p
        on s.products_id = p.products_id
)
select * from joined

