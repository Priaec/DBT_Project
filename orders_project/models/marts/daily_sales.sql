with daily_sales as (
    -- sales for orders
    select
        order_date,
        count(*) as total_orders,
        sum(case
                when status = 'completed' then 1
                else 0
            end
        ) as completed_orders,
        sum(case
                when status = 'completed' then amount
                else 0
            end
        ) as revenue
    from {{ ref('fct_orders') }}
    group by order_date
),

daily_sales_running_revenue as (
    select 
        order_date,
        total_orders,
        completed_orders,
        revenue,
        sum(revenue) over (order by order_date) as running_revenue
    from daily_sales
)

select * from daily_sales_running_revenue