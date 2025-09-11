
WITH orders AS (
    SELECT * FROM {{ ref('int_orders_margin') }}
),
operational AS (
    SELECT * FROM {{ ref('int_orders_operational') }}
),
ship AS (
    SELECT * FROM {{ ref('stg_raw__ship') }}
)
SELECT
    o.date_date,
    COUNT(DISTINCT o.orders_id) AS total_orders,
    ROUND(SUM(o.total_revenue),2) AS total_revenue,
    ROUND(SUM(o.total_revenue)/SUM(o.total_quantity),2) AS avg_basket,
    ROUND(SUM(op.operational_margin),2) AS operational_margin,
    ROUND(SUM(o.total_purchase_cost),2) AS total_purchase_cost,
    ROUND(SUM(CAST(s.shipping_fee AS FLOAT64)),2) AS total_shipping_fee,
    ROUND(SUM(CAST(s.logcost AS FLOAT64)),2) AS total_log_cost,
    ROUND(SUM(o.total_quantity),2) AS total_quantity
FROM orders o
LEFT JOIN operational op
    ON o.orders_id = op.orders_id
LEFT JOIN ship s
    ON o.orders_id = s.orders_id
GROUP BY o.date_date
ORDER BY o.date_date
