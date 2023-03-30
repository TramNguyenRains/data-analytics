WITH refine_format AS(
    SELECT 
        *
    FROM {{ source('olist_ecommerce', 'product_category') }}
),
final AS(
    SELECT 
        *,
    FROM refine_format
)
SELECT * FROM final