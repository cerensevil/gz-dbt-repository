with c as (
  select * from {{ ref('int_campaigns_day') }}
),
f as (
 
  select
    cast(date_date as date)      as date,
    total_orders,
    total_revenue,
    avg_basket,                  
    operational_margin,
    total_purchase_cost,
    total_shipping_fee,
    total_log_cost,
    total_quantity
  from {{ ref('finance_days') }}
)

select
  f.date,
  (f.operational_margin - c.ads_cost)       as ads_margin,
  f.avg_basket                              as average_basket,
  f.operational_margin                      as operational_margin,
  c.ads_cost,
  c.ads_impression,
  c.ads_clicks,
  f.total_quantity                          as quantity,
  f.total_revenue                           as revenue,
  f.total_purchase_cost                     as purchase_cost,
  (f.total_revenue - f.total_purchase_cost) as margin,
  f.total_shipping_fee                      as shipping_fee,
  f.total_log_cost                          as log_cost,
  cast(null as float64)                     as ship_cost   
from f
left join c
  on c.date = f.date
