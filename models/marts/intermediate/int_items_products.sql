WITH int_items_products AS(
    SELECT 
        order_id,
        product_id,
        MAX(seller_id) as seller_id,
        AVG(price) as price,
        COUNT(product_id) as product_quantity
    FROM {{ ref('stg_olist_order_items') }}
    GROUP BY order_id, product_id
),
final as (
    SELECT 
        order_id,
        int_items_products.product_id,
        seller_id,
        price,
        product_quantity,
        product_category
    FROM int_items_products
    LEFT JOIN {{ ref('int_products') }} as products
    ON int_items_products.product_id = products.product_id

)
SELECT * FROM final
