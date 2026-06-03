with 

source as (

    select * from {{ source('transfermarkt', 'competitions') }}

),

renamed as (

    select
        competition_id,
        competition_code,
        name,
        sub_type,
        type,
        country_id,
        country_name,
        domestic_league_code,
        confederation,
        url,
        is_major_national_league as is_top_5_league

    from source

)

select * from renamed