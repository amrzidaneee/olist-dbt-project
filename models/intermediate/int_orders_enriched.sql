select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    p.payment_type,
    p.payment_installments,
    p.payment_value,
    r.review_score,
    r.review_creation_date,
    r.review_answer_timestamp
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_payments') }} p
    on o.order_id = p.order_id
left join (
    select *
    from {{ ref('stg_reviews') }}
    qualify row_number() over (partition by order_id order by review_creation_date desc) = 1
) r on o.order_id = r.order_id