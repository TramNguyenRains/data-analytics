-- Stage station_info table: select required columns

with station_info as(
    
    select station_id,
            name as station_name,
            lat as latitude,
            lon as longtitude

    from {{ source('sf_bikeshare', 'bikeshare_station_info') }}
)

select * from station_info
