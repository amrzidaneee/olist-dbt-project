select
    s.seller_id,
    s.seller_city,
    s.seller_state,
    g.geolocation_lat,
    g.geolocation_lng
from {{ ref('stg_sellers') }} s
left join (
    select
        geolocation_zip_code_prefix,
        avg(geolocation_lat) as geolocation_lat,
        avg(geolocation_lng) as geolocation_lng
    from {{ ref('stg_geolocation') }}
    group by geolocation_zip_code_prefix
) g on s.seller_zip_code_prefix = g.geolocation_zip_code_prefix