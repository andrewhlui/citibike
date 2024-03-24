{{ 
    config(
        materialized="incremental",
        unique_key='ride_id'
    )
}}

select
    ride_id,
    --could technically be a boolean, but keeping it as string keeps it more future-proof in case there becomes a third type of bike
    rideable_type,
    started_at_ts,
    ended_at_ts,
    start_station_id,
    end_station_id,
    --assuming here that we will only have members and non-members in the future based on naming convention of original field
    case 
        when member_casual = 'member' then true
        when member_casual = 'casual' then false 
        else null
    end as is_member, 
    load_dts
from
    {{ ref('stg_citibike') }}

{% if is_incremental() %}
where
    load_dts > (select max(load_dts) from {{ this }})
{% endif %}