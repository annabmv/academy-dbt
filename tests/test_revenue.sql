with monthly_revenue as (
    select
        extract(year from order_date) as order_year,
        extract(month from order_date) as order_month,
        sum(unique_total) as revenue
    from {{ ref('fct_orders') }}
    group by order_year, order_month
)

select *
from monthly_revenue
where revenue = 0