with source as (

    select * from {{ ref('stg_transfermarkt__appearances') }}

),

final as (

    select
        *,
        case
            when month(to_date(date, 'YYYY-MM-DD')) >= 8
                then lpad(right(year(to_date(date, 'YYYY-MM-DD'))::varchar, 2), 2, '0')
                     || '/' ||
                     lpad(right((year(to_date(date, 'YYYY-MM-DD')) + 1)::varchar, 2), 2, '0')
            else
                lpad(right((year(to_date(date, 'YYYY-MM-DD')) - 1)::varchar, 2), 2, '0')
                || '/' ||
                lpad(right(year(to_date(date, 'YYYY-MM-DD'))::varchar, 2), 2, '0')
        end                         as season

    from source

)

select * from final