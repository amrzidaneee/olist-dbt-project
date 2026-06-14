with date_spine as (
    select unnest(
        generate_series(
            '2016-01-01'::date,
            '2019-12-31'::date,
            interval '1 day'
        )
    ) as date
)

select
    date,
    extract(year from date)::int          as year,
    extract(month from date)::int         as month_number,
    monthname(date)                       as month_name,
    extract(quarter from date)::int       as quarter,
    extract(dow from date)::int           as weekday_number,
    dayname(date)                         as weekday_name,
    case 
        when extract(dow from date) in (0, 6) 
        then true else false 
    end                                   as is_weekend,
    strftime(date, '%Y-%m')              as year_month

from date_spine