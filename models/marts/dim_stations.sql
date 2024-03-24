select distinct
    start_station_name as station_name,
    start_station_id as station_id
from
    {{ ref('citbike') }}

union

select distinct
    end_station_name as station_name,
    end_station_id as station_id
from 
    {{ ref('citibike') }}