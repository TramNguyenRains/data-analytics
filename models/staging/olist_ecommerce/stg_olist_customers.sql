WITH refine_format AS(
    SELECT 
        *
    FROM {{ source('olist_ecommerce', 'olist_customers') }}
),
final AS(
    SELECT 
        *,
    FROM refine_format
)
SELECT * FROM final