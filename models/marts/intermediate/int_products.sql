WITH int_products AS(
    SELECT 
        p.product_id,
        product_category_name_english as product_category --change to allign with column names in downstream
    FROM {{ ref('stg_olist_products') }} as p
    JOIN {{ ref('stg_product_category') }} as c
    ON p.product_category_name = c.product_category_name
)
SELECT * FROM int_products