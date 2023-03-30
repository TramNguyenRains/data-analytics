WITH refine_format AS(
    SELECT 
        geolocation_zip_code_prefix,
        ROUND(AVG(geolocation_lat),4) AS geolocation_lat,
        ROUND(AVG(geolocation_lng),4) AS geolocation_lng,
        MAX(geolocation_city) as geolocation_city,
        MIN(geolocation_state) as geolocation_state

    FROM {{ source('olist_ecommerce', 'olist_geolocation') }}
    GROUP BY geolocation_zip_code_prefix
),
final AS(
    SELECT 
        *,
    FROM refine_format
)
SELECT * FROM final
