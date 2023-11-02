WITH refine_format AS(
    SELECT 
        *
    FROM {{ source('olist_ecommerce', 'olist_sellers') }}
),
final AS(
    SELECT 
        *,
    FROM refine_format
)
SELECT * FROM final