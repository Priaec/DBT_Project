with daily_sales as (
    select * from {{ ref('daily_sales') }}
),

int_dates as (
    select * from {{ ref('int_dates') }}
),

daily_sales_all_days as (
    select
        sales_date,
        coalesce(total_orders, 0) as total_orders,
        coalesce(completed_orders, 0) as completed_orders,
        coalesce(revenue, 0.0) as revenue,
        sum(coalesce(revenue, 0.0)) over (order by sales_date) as running_revenue
        from int_dates d
    left join daily_sales ds on ds.order_date = d.sales_date
)

select * from daily_sales_all_days
order by sales_date