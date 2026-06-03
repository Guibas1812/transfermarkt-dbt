with transfers as (

    select * from {{ ref('stg_transfermarkt__transfers') }}

),

transfer_income as (

    select
        transfer_season                             as season,
        to_club_id                                  as club_id,
        sum(coalesce(transfer_fee, 0))              as total_transfer_income,
        sum(coalesce(market_value_in_eur, 0))       as total_market_value_in,
        count(player_id)                            as players_acquired

    from transfers
    group by 1, 2

),

transfer_spend as (

    select
        transfer_season                             as season,
        from_club_id                                as club_id,
        sum(coalesce(transfer_fee, 0))              as total_transfer_spend,
        sum(coalesce(market_value_in_eur, 0))       as total_market_value_out,
        count(player_id)                            as players_sold

    from transfers
    group by 1, 2

),

joined as (

    select
        coalesce(i.season, s.season)                as season,
        coalesce(i.club_id, s.club_id)              as club_id,
        coalesce(i.total_transfer_income, 0)        as total_transfer_income,
        coalesce(s.total_transfer_spend, 0)         as total_transfer_spend,
        coalesce(i.total_market_value_in, 0)        as total_market_value_in,
        coalesce(s.total_market_value_out, 0)       as total_market_value_out,
        coalesce(i.players_acquired, 0)             as players_acquired,
        coalesce(s.players_sold, 0)                 as players_sold

    from transfer_income i
    full outer join transfer_spend s
        on  i.season  = s.season
        and i.club_id = s.club_id

)

select
    season,
    club_id,
    players_acquired,
    total_transfer_income,
    total_transfer_income - total_market_value_in       as income_vs_market_value,
    players_sold ,
    total_transfer_spend,
    total_transfer_spend  - total_market_value_out      as spend_vs_market_value
          
from joined
order by season, club_id