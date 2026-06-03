with transfers as (

    select * from {{ ref('stg_transfermarkt__transfers') }}

)

select
    transfer_id,
    player_id,
    player_name,
    transfer_date,
    transfer_season,
    from_club_id,
    from_club_name,
    to_club_id,
    to_club_name,
    coalesce(transfer_fee, 0)                                       as transfer_fee,
    market_value_in_eur,
    coalesce(transfer_fee, 0) - coalesce(market_value_in_eur, 0)   as fee_vs_market_value

from transfers

order by transfer_date desc nulls last