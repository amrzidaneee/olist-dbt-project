select
    product_id,
    product_category_name,
    product_category_name_english  as category_english

from {{ ref('int_products_enriched') }}