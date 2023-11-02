WITH reconcile AS(
    SELECT 
        order_id,
        product_id,
        COUNT(product_id) as product_count,
        AVG(price) as price,
        AVG(freight_value) as freight_value,
        SUM(payment_value) as total_payment
    FROM {{ ref('fct_orders_items_payments') }}
    GROUP BY order_id,product_id
),
calculated_amount AS(
    SELECT 
        order_id,
        product_id,
        product_count*price as product_amount,
        freight_value as freight_value,
        total_payment
    FROM reconcile
),
final AS(
    SELECT
        order_id,
        SUM(product_amount) OVER(PARTITION BY order_id) as total_product_amount,
        AVG(freight_value) OVER(PARTITION BY order_id)  as freight_value,
        ROUND((SUM(product_amount) OVER(PARTITION BY order_id) + AVG(freight_value) OVER(PARTITION BY order_id)),2) as total_calculated_amount,
        total_payment
    FROM calculated_amount
), 
unmatch_condition AS (
    SELECT *
    FROM final
    WHERE total_calculated_amount <> total_payment
    ),
unmatch_records AS(
    SELECT *
    FROM {{ ref('fct_orders_items_payments') }}
    WHERE order_id IN (SELECT order_id FROM unmatch_condition)
    ORDER BY order_id,product_id,order_item_id
),
/* Results of reconciliation */
result_condition AS
    (SELECT 
        order_id,
        (CASE WHEN total_calculated_amount <> total_payment THEN 'Unmatch' ELSE 'Match' END) as result,
        ABS(100*(total_calculated_amount-total_payment)/total_payment) as absolute_diff_percentage
    FROM final)

SELECT 
    DISTINCT result,
    COUNT(*) OVER(PARTITION BY result) as records_count,
    ROUND(100*COUNT(*) OVER(PARTITION BY result)/ COUNT(*) OVER(),2) as records_percentage,
    ROUND(AVG(absolute_diff_percentage) OVER(PARTITION BY result),2) as absolute_diff_percentage
FROM result_condition
/* Further investigation : there might be some discount or additional fee applied that are not captured in the dataset*/ 

