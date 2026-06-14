select
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    o.customer_id,

    o.order_purchase_timestamp          as purchase_at,
    o.order_delivered_customer_date     as delivered_customer_at,
    cast(o.order_purchase_timestamp as date) as purchase_date_id,

    o.order_status,
    o.payment_type,
    o.payment_installments,
    o.review_score,

    
    oi.price                            as total_item_value,
    oi.freight_value                    as total_freight_value,
    oi.price + oi.freight_value         as total_order_value,
    o.payment_value                     as total_payment_value

from {{ ref('stg_order_items') }} oi

left join {{ ref('int_orders_enriched') }} o
    on oi.order_id = o.order_id

left join {{ ref('int_products_enriched') }} p
    on oi.product_id = p.product_id