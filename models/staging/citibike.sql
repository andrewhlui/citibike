select
    nullif($1, '')::varchar as ride_id,
    nullif($2, '')::varchar as rideable_type,
    nullif($3, '')::varchar as started_at,
    nullif($4, '')::varchar as ended_at,
    nullif($5, '')::varchar as start_station_name,
    nullif($6, '')::varchar as start_station_id,
    nullif($7, '')::varchar as end_station_name,
    nullif($8, '')::varchar as end_station_id,
    nullif($9, '')::varchar as start_lat,
    nullif($10, '')::varchar as start_lng,
    nullif($11, '')::varchar as end_lat,
    nullif($12, '')::varchar as end_lng,
    nullif($13, '')::varchar as member_casual
from
    {{ all_files(stage = 'citibike_stage') }}

--ride_id,rideable_type,started_at,ended_at,start_station_name,start_station_id,end_station_name,end_station_id,start_lat,start_lng,end_lat,end_lng,member_casual
--58F2CA262B50E256,classic_bike,2024-01-25 20:39:09,2024-01-25 20:44:07,Broadway & E 14 St,5905.12,Ave A & E 11 St,5703.13,40.73454567,-73.99074142,40.72854745023944,-73.98175925016403,member