with player_match_stats as (

    select * from {{ ref('int_player_match_stats') }}

),

games_info as (

    select
        game_id,
        competition_id,
        round,
        date,
        stadium,
        attendance,
        competition_type,
        season

    from {{ ref('int_games_info') }}

),

final as (

    select
        p.appearance_id,
        p.game_id,
        p.player_id,
        p.player_name,
        p.player_club_id,
        p.player_current_club_id,
        p.date,
        p.season,
        g.competition_id,
        g.round,
        g.stadium,
        g.attendance,
        g.competition_type,
        p.yellow_cards,
        p.red_cards,
        p.goals,
        p.assists,
        p.minutes_played

    from player_match_stats p
    left join games_info g
        on p.game_id = g.game_id

)

select * from final