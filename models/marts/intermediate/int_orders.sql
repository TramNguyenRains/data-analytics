WITH int_orders AS(
    SELECT *,
    {{datediff('purchase_date','delivered_carrier_date','day')}} as preparing_days,
    {{datediff('delivered_carrier_date','delivered_customer_date','day')}} as shipping_days,
    (CASE 
        WHEN estimated_delivery_date < delivered_customer_date THEN 'Sooner'
        WHEN estimated_delivery_date = delivered_customer_date THEN 'On time'
        WHEN estimated_delivery_date > delivered_customer_date THEN 'Later'
        END) as delivered_vs_estimated
    FROM {{ ref('stg_olist_orders') }}
)
SELECT * FROM int_orders