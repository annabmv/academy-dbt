with
    sales_agg_region as (
        select
            dim_employee.sk_employee
            , dim_address.territory_name as region
            , count(distinct fct_orders.sales_order_id) as total_orders_handled
            , SUM(fct_orders.order_qty) as total_products_sold
            , SUM(fct_orders.product_total) as total_sales_value
        from {{ ref('fct_orders') }} as fct_orders
        left join {{ ref('dim_employee') }} as dim_employee
            on fct_orders.sk_employee = dim_employee.sk_employee
        left join {{ ref('dim_address') }} as dim_address
            on fct_orders.sk_address = dim_address.sk_address
        group by dim_employee.sk_employee, dim_address.territory_name
    )

select
    sales_agg_region.sk_employee
    , sales_agg_region.region
    , dim_employee.full_name
    , sales_agg_region.total_orders_handled
    , sales_agg_region.total_products_sold
    , round(sales_agg_region.total_sales_value, 2) as total_sales
from sales_agg_region
join {{ ref('dim_employee') }} as dim_employee
    on sales_agg_region.sk_employee = dim_employee.sk_employee
order by sales_agg_region.region, total_sales desc

