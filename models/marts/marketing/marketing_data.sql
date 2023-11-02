select 
*
from {{ref('fct_orders')}} as orders
inner join {{ref('dim_customers')}} as customers 
using(customer_id)