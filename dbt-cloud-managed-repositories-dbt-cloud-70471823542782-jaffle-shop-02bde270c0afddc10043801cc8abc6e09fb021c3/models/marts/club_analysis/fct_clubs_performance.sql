with transfer_info as (

    select * from {{ ref('int_clubs_transfer_info') }}

),

attendance as (

    select * from {{ ref('int_clubs_attendance_summary') }}

),

transfer_aggregated as (

    select
        club_id,
        count(distinct season)                          as number_of_seasons,
        sum(players_acquired)                           as total_players_acquired,
        sum(total_transfer_income)                      as total_transfer_income,
        sum(players_sold)                               as total_players_sold,
        sum(total_transfer_spend)                       as total_transfer_spend,
        sum(total_transfer_income)
            - sum(total_transfer_spend)                 as net_transfer_balance,
        sum(total_transfer_income)
            / nullif(count(distinct season), 0)         as avg_transfer_income_per_season,
        sum(total_transfer_spend)
            / nullif(count(distinct season), 0)         as avg_transfer_spend_per_season,
        (sum(total_transfer_income) - sum(total_transfer_spend))
            / nullif(count(distinct season), 0)         as avg_profit_loss_per_season

    from transfer_info
    group by 1

),

final as (

    select
        t.club_id,
        t.number_of_seasons,
        t.total_players_acquired,
        t.total_transfer_income,
        t.avg_transfer_income_per_season,
        t.total_players_sold,
        t.total_transfer_spend,
        t.avg_transfer_spend_per_season,
        t.net_transfer_balance,
        t.avg_profit_loss_per_season,
        a.total_home_games,
        a.avg_attendance,
        a.stadium_seats,
        a.avg_attendance_pct

    from transfer_aggregated t
    left join attendance a
        on t.club_id = a.club_id

)

select * from final