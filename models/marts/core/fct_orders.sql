WITH fct_orders AS(
    SELECT
        /*orders fields*/
        items.order_id,
        orders.customer_id,
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
        items.product_id,
        seller_id,
        price,
        product_quantity,
        product_category
        
    FROM {{ ref('int_items_products') }} as items
    JOIN {{ ref('int_orders') }} as orders
    ON  items.order_id = orders.order_id
),
final AS(
    SELECT * FROM fct_orders
)
SELECT * FROM final



