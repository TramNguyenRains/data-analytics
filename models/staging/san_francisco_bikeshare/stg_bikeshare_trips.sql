with trips as (

    select *
    from {{ ref('sf_bikeshare','bikeshare_trips') }}

)

select * from trips