{{ 
    config(
        materialized="incremental",
        unique_key='ride_id'
    )
}}

select
    ride_id,
    rideable_type,
    try_to_timestamp(started_at) as started_at_ts,
    try_to_timestamp(ended_at) as ended_at_ts,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    try_to_numeric(start_lat) as start_lat,
    try_to_numeric(start_lng) as start_lng,
    try_to_numeric(end_lat) as end_lat,
    try_to_numeric(end_lng) as end_lng,
    case 
        when member_casual = 'casual' then false
        when member_casual = 'member' then true
        else null
    end as is_member,
    file_name,
    current_timestamp() as load_dts
from
    {{ ref('stg_citibike') }}
{% if is_incremental() %}
where
    file_name not in (select file_name from {{ this }})
{% endif %}