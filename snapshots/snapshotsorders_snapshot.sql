{% snapshot orders_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='order_id',
        strategy='check',
        check_cols=['order_status', 'order_delivered_customer_date'],
    )
}}

select
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date
from {{ ref('stg_orders') }}

{% endsnapshot %}