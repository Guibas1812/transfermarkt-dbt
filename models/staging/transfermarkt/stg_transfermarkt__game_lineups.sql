with 

source as (

    select * from {{ source('transfermarkt', 'game_lineups') }}

),

renamed as (

    select
        game_lineups_id,
        date,
        game_id,
        player_id,
        club_id,
        player_name,
        type,
        position,
        number,
        team_captain

    from source

)

select * from renamed