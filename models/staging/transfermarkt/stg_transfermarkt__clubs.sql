with 

source as (

    select * from {{ source('transfermarkt', 'clubs') }}

),

renamed as (

    select
        club_id,
        club_code,
        name,
        domestic_competition_id,
        total_market_value,
        squad_size,
        average_age,
        foreigners_number,
        foreigners_percentage,
        national_team_players,
        stadium_name,
        stadium_seats,
        net_transfer_record,
        coach_name,
        last_season,
        filename,
        url

    from source

)

select * from renamed