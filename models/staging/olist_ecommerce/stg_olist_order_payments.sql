WITH refine_format AS(
    SELECT 
        order_id,
        payment_sequential,
        payment_type,
        payment_installments,
        ROUND(payment_value,2) as payment_value
    FROM {{ source('olist_ecommerce', 'olist_order_payments_dataset') }}
),
final AS(
    SELECT 
        *,
    FROM refine_format
)
SELECT * FROM final