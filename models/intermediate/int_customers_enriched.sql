select
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    g.geolocation_lat,
    g.geolocation_lng
from {{ ref('stg_customers') }} c
left join (
    select
        geolocation_zip_code_prefix,
        avg(geolocation_lat) as geolocation_lat,
        avg(geolocation_lng) as geolocation_lng
    from {{ ref('stg_geolocation') }}
    group by geolocation_zip_code_prefix
) g on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix