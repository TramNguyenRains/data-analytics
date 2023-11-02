SELECT  *
    FROM {{ ref('stg_olist_orders') }} 
    RIGHT JOIN {{ ref('int_items_products') }} 
    ON stg_olist_orders.order_id = int_items_sellers.order_id
    WHERE customer_id IS NULL