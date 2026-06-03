-- net_transfer_balance must equal income minus spend
select * from {{ ref('fct_clubs_performance') }}
where net_transfer_balance != total_transfer_income - total_transfer_spend