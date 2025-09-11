with sales_margin as (
    select * from {{ ref('int_sales_margin') }}
)
select
    orders_id,
    date_date,
    sum(revenue) as total_revenue,
    sum(quantity) as total_quantity,
    sum(purchased_cost) as total_purchase_cost,
    sum(margin) as total_margin
from sales_margin
group by orders_id, date_date

