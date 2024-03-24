{{ 
    config(
        materialized="incremental",
        unique_key='station_id'
    )
}}

{% for type in ['start', 'end'] %}

select distinct
    {{ type }}_station_name as station_name,
    {{ type }}_station_id as station_id
    {{ type }}_lat as latitude,
    {{ type }}_lng as longitude, 
    '{{ type }}' as source, 
    load_dts
from
    {{ ref('stg_citibike') }}

{% if is_incremental() %}
where
    load_dts > (select max(load_dts) from {{ this }})
{% endif %}

{% if not loop.last -%} union {%- endif %}

{% endfor %}