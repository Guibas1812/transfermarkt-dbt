with 

source as (

    select * from {{ source('transfermarkt', 'club_games') }}

),

renamed as (

    select
        game_id,
        club_id,
        own_goals,
        own_position,
        own_manager_name,
        opponent_id,
        opponent_goals,
        opponent_position,
        opponent_manager_name,
        hosting,
        is_win

    from source

)

select * from renamed