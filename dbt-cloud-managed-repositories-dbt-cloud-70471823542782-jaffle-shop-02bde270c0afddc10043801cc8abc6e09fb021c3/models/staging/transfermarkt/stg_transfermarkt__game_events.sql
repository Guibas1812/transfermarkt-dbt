with 

source as (

    select * from {{ source('transfermarkt', 'game_events') }}

),

renamed as (

    select
        game_event_id,
        date,
        game_id,
        minute,
        type,
        club_id,
        club_name,
        player_id,
        description,
        player_in_id,
        player_assist_id

    from source

)

select * from renamed