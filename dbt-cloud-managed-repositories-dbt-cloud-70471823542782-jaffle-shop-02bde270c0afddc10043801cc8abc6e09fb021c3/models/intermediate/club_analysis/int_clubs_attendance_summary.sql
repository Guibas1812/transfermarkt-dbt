with league_games as (
    select
        home_club_id,
        game_id,
        attendance
    from {{ ref('int_league_games_only') }}
),

clubs as (
    select
        club_id,
        stadium_seats
    from {{ ref('int_clubs_enriched') }}
),

attendance_summary as (
    select
        home_club_id                                as club_id,
        sum(attendance)                             as total_attendance,
        count(distinct game_id)                     as total_home_games,
        round(
            sum(attendance) / nullif(count(distinct game_id), 0)
        , 0)                                        as avg_attendance
    from league_games
    where attendance is not null
    group by home_club_id
),

final as (
    select
        a.club_id,
        a.total_home_games,
        a.avg_attendance,
        c.stadium_seats,
        round(
            a.avg_attendance / nullif(c.stadium_seats, 0) * 100
        , 2)                                        as avg_attendance_pct
    from attendance_summary a
    left join clubs c
        on a.club_id = c.club_id
)

select * from final