-- Transfer fees should never be negative
select * from {{ ref('fct_players_transfers') }}
where transfer_fee is not null and transfer_fee < 0