{% for type in ['start', 'end'] %}

select distinct
    {{ type }}_station_name as station_name,
    {{ type }}_station_id as station_id
    {{ type }}_lat as latitude,
    {{ type }}_lng as longitude
from
    {{ ref('citbike') }}

{% if not loop.last -%} union {%- endif %}

{% endfor %}