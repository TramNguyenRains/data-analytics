/* For the purpose of demo, I choose only 6 months data in 2018 to Aug-2018 and for completed order*/

WITH refine_format AS(
    SELECT 
        *,
        {{date_trunc('year','order_purchase_timestamp')}} as year_order
    FROM {{ source('olist_ecommerce', 'olist_orders_dataset') }}
),
select_record AS(
    SELECT 
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp as purchase_date,
        order_approved_at as approved_date,
        order_delivered_carrier_date as delivered_carrier_date,
        order_delivered_customer_date as delivered_customer_date,
        order_estimated_delivery_date as estimated_delivery_date
    FROM refine_format

),
final AS(
    SELECT * 
    FROM select_record  )                                           
SELECT * FROM final