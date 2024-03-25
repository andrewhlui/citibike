{{ 
    config(
        materialized="incremental",
        unique_key='station_id'
    )
}}

with cte_stations as (
{% for type in ['start', 'end'] %}

select distinct
    {{ type }}_station_name as station_name,
    {{ type }}_station_id as station_id,
    {{ type }}_lat as latitude,
    {{ type }}_lng as longitude,
    load_dts
from
    {{ ref('stg_citibike') }}

{% if is_incremental() %}
where
    load_dts > (select max(load_dts) from {{ this }})
{% endif %}

{% if not loop.last -%} union {%- endif %}

{% endfor %}

)

select
    station_name,
    station_id,
    latitude,
    longitude
from
    cte_stations
--lat/long is not unique
qualify
    row_number() over (partition by station_id order by latitude, longitude) = 1