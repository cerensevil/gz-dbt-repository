with orders_margin as (
    select * from {{ ref('int_orders_margin') }}
),
ship as (
    select * from {{ ref('stg_raw__ship') }}
)
select
    o.orders_id,
    o.date_date,
    o.total_margin 
      + CAST(s.shipping_fee AS FLOAT64)
      - CAST(s.logcost AS FLOAT64)
      - CAST(s.ship_cost AS FLOAT64) as operational_margin
from orders_margin o
left join ship s
    on o.orders_id = s.orders_id


