with player_match_stats as (

    select * from {{ ref('int_player_match_stats') }}

),

games_info as (

    select
        game_id,
        competition_id,
        competition_type

    from {{ ref('int_games_info') }}

),

joined as (

    select
        p.player_id,
        p.player_name,
        p.player_club_id,
        p.season,
        g.competition_id,
        g.competition_type,
        p.yellow_cards,
        p.red_cards,
        p.goals,
        p.assists,
        p.minutes_played,
        p.appearance_id

    from player_match_stats p
    left join games_info g
        on p.game_id = g.game_id

),

final as (

    select
        player_id,
        player_name,
        player_club_id,
        season,
        competition_id,
        competition_type,
        count(appearance_id)                                        as total_appearances,
        sum(goals)                                                  as total_goals,
        sum(assists)                                                as total_assists,
        sum(minutes_played)                                         as total_minutes_played,
        sum(yellow_cards)                                           as total_yellow_cards,
        sum(red_cards)                                              as total_red_cards,
        round(sum(goals)
            / nullif(sum(minutes_played), 0) * 90, 2)              as goals_per_90,
        round(sum(assists)
            / nullif(sum(minutes_played), 0) * 90, 2)              as assists_per_90,
        round((sum(goals) + sum(assists))
            / nullif(sum(minutes_played), 0) * 90, 2)              as goal_contributions_per_90

    from joined
    group by 1, 2, 3, 4, 5, 6

)

select * from final