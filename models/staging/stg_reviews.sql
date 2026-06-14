select
    review_id,
    order_id,
    review_score,
    review_creation_date,
    review_answer_timestamp
from {{ source('olist_raw', 'olist_order_reviews_dataset') }}