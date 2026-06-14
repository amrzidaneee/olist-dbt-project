select
    seller_id,
    seller_city,
    seller_state,
    geolocation_lat,
    geolocation_lng

from {{ ref('int_sellers_enriched') }}