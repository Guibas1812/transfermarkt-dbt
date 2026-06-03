-- Every appearance must link to a known player
{{ config(severity='warn') }}

select a.player_id
from {{ ref('stg_transfermarkt__appearances') }} a
left join {{ ref('dim_players') }} p on a.player_id = p.player_id
where p.player_id is null