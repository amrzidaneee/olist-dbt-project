select
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date
from {{ source('olist_raw', 'olist_orders_dataset') }}