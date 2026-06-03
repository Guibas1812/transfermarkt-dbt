with source as (

    select * from {{ ref('stg_transfermarkt__players') }}

),

final as (

    select
        player_id,
        first_name,
        last_name,
        name,
        last_season,
        player_code,
        country_of_birth,
        city_of_birth,
        country_of_citizenship,
        date_of_birth,
        datediff('year', to_date(date_of_birth, 'YYYY-MM-DD HH24:MI:SS'), current_date())  as age,
        sub_position,
        position,
        foot,
        height_in_cm,
        contract_expiration_date,
        agent_name,
        market_value_in_eur,
        highest_market_value_in_eur

    from source

)

select * from final