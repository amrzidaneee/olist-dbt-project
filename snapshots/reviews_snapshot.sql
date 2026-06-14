{% snapshot reviews_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='review_id',
        strategy='check',
        check_cols=['review_score'],
    )
}}

select
    review_id,
    order_id,
    review_score,
    review_creation_date,
    review_answer_timestamp
from {{ ref('stg_reviews') }}

{% endsnapshot %}