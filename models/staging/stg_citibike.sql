{{ 
    config(
        materialized="incremental",
        unique_key='ride_id'
    )
}}

select
    nullif($1, '')::varchar as ride_id,
    nullif($2, '')::varchar as rideable_type,
    nullif($3, '')::timestamp as started_at_ts,
    nullif($4, '')::timestamp as ended_at_ts,
    nullif($5, '')::varchar as start_station_name,
    nullif($6, '')::varchar as start_station_id,
    nullif($7, '')::varchar as end_station_name,
    nullif($8, '')::varchar as end_station_id,
    nullif($9, '')::numeric as start_lat,
    nullif($10, '')::numeric as start_lng,
    nullif($11, '')::numeric as end_lat,
    nullif($12, '')::numeric as end_lng,
    nullif($13, '')::varchar as member_casual,
    --does not currently handle restatements of existing files
    split_part($14, '/', -1) as file_name,
    current_timestamp() as load_dts

from
    {{ all_files(stage = 'citibike_stage') }}

{% if is_incremental() %}

--don't reload a file if it's already been loaded. this obviously doesn't handle restatements, but this source doesn't have that very commonly
where
    file_name not in (select file_name from {{ this }} )
{% endif %}
