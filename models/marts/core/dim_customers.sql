WITH dim_customers AS(
    SELECT 
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    geolocation_lat as customer_geo_lat,
    geolocation_lng as customer_geo_lng,
    geolocation_city as customer_geo_city,
    geolocation_state as customer_geo_state
    FROM {{ ref('stg_olist_customers') }} as c
    JOIN {{ ref('stg_olist_geolocation') }} as g
    ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
),
final AS (
    SELECT *
    FROM dim_customers
)
SELECT * FROM final