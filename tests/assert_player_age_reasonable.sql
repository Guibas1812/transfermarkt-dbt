-- Players outside 14-65 range are likely data errors
select * from {{ ref('dim_players') }}
where age is not null
  and (age < 14 or age > 65)