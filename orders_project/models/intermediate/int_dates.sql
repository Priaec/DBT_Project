with int_dates as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2026-10-01' as date)",
        end_date="cast('2026-10-22' as date)"
    ) }}
)

select 
    cast(date_day as date) as sales_date
from int_dates