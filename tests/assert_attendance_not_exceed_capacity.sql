-- Attendance can't exceed stadium capacity
{{ config(severity='warn') }}

select * from {{ ref('fct_clubs_performance') }}
where avg_attendance > stadium_seats