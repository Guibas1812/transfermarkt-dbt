with 

source as (

    select * from {{ source('transfermarkt', 'player_valuations') }}

),

renamed as (

    select
        player_id,
        date,
        market_value_in_eur,
        current_club_name,
        current_club_id,
        player_club_domestic_competition_id

    from source

)

select * from renamed