WITH orders_items_join AS(
    SELECT 
        orders.order_id,
        orders.order_status,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date,
        price,
        freight_value
    FROM {{ ref('stg_olist_orders') }} as orders
    JOIN {{ ref('stg_olist_order_items') }} as items
    ON orders.order_id = items.order_id
),
fct_orders_items_payments AS(
    SELECT 
        oi.order_id,
        oi.order_status,
        order_item_id,
        product_id,
        price,
        freight_value,
        p.payment_sequential,
        p.payment_type,
        p.payment_installments,
        p.payment_value
    FROM orders_items_join as oi
    JOIN {{ ref('stg_olist_order_payments') }} as p
    ON oi.order_id = p.order_id
)
SELECT * FROM fct_orders_items_payments