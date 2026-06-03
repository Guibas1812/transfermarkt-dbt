with competitions as (
    select
        competition_id,
        competition_code,
        name                    as competition_name,
        sub_type,
        type,
        country_id,
        country_name,
        domestic_league_code,
        confederation,
        is_top_5_league
    from {{ ref('stg_transfermarkt__competitions') }}
)

select * from competitions