WITH int_products AS(
    SELECT 
        p.product_id,
        c.string_field_1 as product_category
    FROM {{ ref('stg_olist_products') }} as p
    JOIN {{ ref('stg_product_category') }} as c
    ON p.product_category_name = c.string_field_0
)
SELECT * FROM int_products