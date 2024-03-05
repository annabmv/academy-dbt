with
    employee as (
        select
            sk_employee
            , full_name
        from {{ ref('dim_employee') }}
    )

    , region as (
        select
            sk_address
            , territory_name
        from {{ ref('dim_address') }}
    )

    , sales as (
        select *
        from {{ ref('fct_orders') }}
    )

    , sales_agg_region as (
        select
            employee.sk_employee
            , region.territory_name as region_name
            , extract(year from sales.order_date) as agg_year
            , extract(month from sales.order_date) as agg_month
            , count(distinct sales.sales_order_id) as total_orders_handled
            , sum(sales.order_qty) as total_products_sold
            , sum(sales.product_total) as total_sales_value
        from sales
        left join employee
            on sales.sk_employee = employee.sk_employee
        left join region
            on sales.sk_address = region.sk_address
        group by 
            employee.sk_employee
            , region.territory_name
            , agg_year
            , agg_month
    )

select
    employee.sk_employee
    , region_name
    , agg_year
    , agg_month
    , case
        when agg_month = 1 then 'January'
        when agg_month = 2 then 'February'
        when agg_month = 3 then 'March'
        when agg_month = 4 then 'April'
        when agg_month = 5 then 'May'
        when agg_month = 6 then 'June'
        when agg_month = 7 then 'July'
        when agg_month = 8 then 'August'
        when agg_month = 9 then 'September'
        when agg_month = 10 then 'October'
        when agg_month = 11 then 'November'
        when agg_month = 12 then 'December'
    end as month_name
    , employee.full_name
    , total_orders_handled
    , total_products_sold
    , round(total_sales_value, 2) as total_sales
from sales_agg_region
join employee
    on sales_agg_region.sk_employee = employee.sk_employee
order by 
    sales_agg_region.region_name
    , sales_agg_region.agg_year desc
    , sales_agg_region.agg_month desc

