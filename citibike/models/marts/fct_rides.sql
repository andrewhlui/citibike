{{ 
    config(
        materialized="incremental",
        unique_key='ride_id'
    )
}}

select
    ride_id,
    rideable_type,
    started_at_ts,
    ended_at_ts,
    start_station_id,
    end_station_id,
    is_member, 
    load_dts
from
    {{ ref('int_citibike') }}

{% if is_incremental() %}
where
    load_dts > (select max(load_dts) from {{ this }})
{% endif %}