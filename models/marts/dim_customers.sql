select
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state,
    geolocation_lat,
    geolocation_lng

from {{ ref('int_customers_enriched') }}