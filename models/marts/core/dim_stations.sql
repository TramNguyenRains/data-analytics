
with station_info as (
    select * from {{ ref('stg_station_info') }}
) ,

station_status as (
    select * from {{ ref('stg_station_status') }}
),

dim_stations as (
    select * 
    from station_info
    left join station_status
    using (station_id)
)

select * from dim_stations