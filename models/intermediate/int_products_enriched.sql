select
    p.product_id,
    p.product_category_name,
    t.product_category_name_english

from {{ ref('stg_products') }} p

left join {{ ref('stg_category_translation') }} t
    on p.product_category_name = t.product_category_name