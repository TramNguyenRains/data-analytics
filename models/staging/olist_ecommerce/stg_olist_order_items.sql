WITH refine_format AS(
    SELECT 
        *
    FROM {{ source('olist_ecommerce', 'olist_order_items_dataset') }}
),
final AS(
    SELECT 
        *,
    FROM refine_format
)
SELECT * FROM final
