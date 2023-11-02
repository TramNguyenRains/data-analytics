WITH refine_format AS(
    SELECT 
        *
    FROM {{ source('olist_ecommerce', 'olist_products') }}
),
final AS(
    SELECT 
        *,
    FROM refine_format
)
SELECT * FROM final