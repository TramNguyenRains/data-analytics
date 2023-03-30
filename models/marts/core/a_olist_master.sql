WITH olist_master AS(
    SELECT
        /*orders fields*/
        orders.order_id,
        orders.customer_id,
        sellers.seller_id,
        order_status,
        purchase_date,
        approved_date,
        delivered_carrier_date,
        delivered_customer_date,
        estimated_delivery_date,
        preparing_days,
        shipping_days,
        delivered_vs_estimated,

        /*product fields*/
        product_id,
        price,
        product_quantity,
        orders.product_category,

        /*customers field*/
        customer_geo_lat,
        customer_geo_lng,
        customer_geo_city,
        customer_geo_state,

        /*seller fields*/
        seller_geo_lat,
        seller_geo_lng,
        seller_geo_city,
        seller_geo_state,
    FROM {{ ref('fct_orders') }} as orders
    JOIN {{ ref('dim_customers') }} as customers 
    ON orders.customer_id = customers.customer_id
    JOIN {{ ref('dim_sellers') }} as sellers
    ON orders.seller_id = sellers.seller_id

),
final AS(
    SELECT * FROM olist_master
)
SELECT * FROM final



