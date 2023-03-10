-- Stage table 


with station_status as(

    select station_id,
        num_bikes_available,
        num_bikes_disabled,
        num_docks_available,
        num_docks_disabled,
        is_installed,
        is_renting,
        is_returning

    from {{ source('sf_bikeshare', 'bikeshare_station_status') }}

)

select * from station_status