/* For the purpose of demo, I choose only 6 months data in 2018 to Aug-2018 and for completed order*/

WITH refine_format AS(
    SELECT 
        *,
        {{date_trunc('year','order_purchase_timestamp')}} as year_order
    FROM {{ source('olist_ecommerce', 'olist_orders') }}
),
select_record AS(
    SELECT 
        order_id,
        customer_id,
        order_status,
        FORMAT_DATE('%Y-%m-%d',order_purchase_timestamp) as purchase_date,
        FORMAT_DATE('%Y-%m-%d',order_approved_at) as approved_date,
        FORMAT_DATE('%Y-%m-%d',order_delivered_carrier_date) as delivered_carrier_date,
        FORMAT_DATE('%Y-%m-%d',order_delivered_customer_date) as delivered_customer_date,
        FORMAT_DATE('%Y-%m-%d',order_estimated_delivery_date) as estimated_delivery_date
    FROM refine_format

),
final AS(
    SELECT * 
    FROM select_record  )                                           
SELECT * FROM final