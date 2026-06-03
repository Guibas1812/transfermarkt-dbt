with clubs as (
    select
        club_id,
        club_code,
        name                        as club_name,
        domestic_competition_id,
        total_market_value,
        squad_size,
        average_age,
        foreigners_number,
        foreigners_percentage,
        national_team_players,
        stadium_name,
        stadium_seats,
        net_transfer_record,
        coach_name,
        last_season,
        filename,
        url
    from {{ ref('stg_transfermarkt__clubs') }}
),

competitions as (
    select
        competition_id,
        country_name,
        confederation,
        is_top_5_league
    from {{ ref('stg_transfermarkt__competitions') }}
),

final as (
    select
        -- club keys
        c.club_id,
        c.club_code,
        c.domestic_competition_id,

        -- club attributes
        c.club_name,
        c.total_market_value,
        c.squad_size,
        c.average_age,
        c.foreigners_number,
        c.foreigners_percentage,
        c.national_team_players,
        c.stadium_name,
        c.stadium_seats,
        c.net_transfer_record,
        c.coach_name,
        c.last_season,
        c.filename,
        c.url,

        -- competition / country attributes
        comp.country_name,
        comp.confederation,
        comp.is_top_5_league

    from clubs c
    left join competitions comp
        on c.domestic_competition_id = comp.competition_id
)

select * from final