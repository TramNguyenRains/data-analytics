WITH dim_sellers AS(
    SELECT 
    seller_id,
    seller_zip_code_prefix,
    geolocation_lat as seller_geo_lat,
    geolocation_lng as seller_geo_lng,
    geolocation_city as seller_geo_city,
    geolocation_state as seller_geo_state
    FROM {{ ref('stg_olist_sellers') }} as c
    LEFT JOIN {{ ref('stg_olist_geolocation') }} as g
    ON c.seller_zip_code_prefix = g.geolocation_zip_code_prefix
),
final AS (
    SELECT *
    FROM dim_sellers
)
SELECT * FROM final