WITH refine_format AS(
    SELECT 
        *
    FROM {{ source('olist_ecommerce', 'product_category_name_translation') }}
),
final AS(
    SELECT 
        *,
    FROM refine_format
)
SELECT * FROM final