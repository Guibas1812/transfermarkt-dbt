with source as (
    select * from {{ ref('stg_transfermarkt__games') }}
),

league_games as (
    select *
    from source
    where competition_type = 'domestic_league')

select * from league_games