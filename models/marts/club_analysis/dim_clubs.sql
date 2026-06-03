with clubs as (
    select
        club_id,
        club_code,
        domestic_competition_id,
        club_name,
        stadium_name,
        stadium_seats,
        country_name,
        confederation,
        is_top_5_league
    from {{ ref('int_clubs_enriched') }}
),

final as (
    select
        -- keys
        c.club_id,
        c.domestic_competition_id   as competition_id,

        -- club attributes
        c.club_name,
        c.club_code,
        c.stadium_name,
        c.stadium_seats,

        -- competition / country attributes
        c.country_name,
        c.confederation,
        c.is_top_5_league

    from clubs c
)

select * from final