with
    order_detail as (
        select *
        from {{ ref('int_order_detail') }}
    )

    , order_header as (
        select *
        from {{ ref('int_order_header') }}
    )

    , fct_orders as (
        select
            order_header.sk_customer
            , order_header.sk_employee
            , order_header.sk_address
            , order_header.sk_payment
            , order_header.sk_sales_reason
            , sk_products
            , order_header.sales_order_id
            , sales_order_detail_id -- Retain line-item level granularity
            , order_header.store_id
            , order_qty
            , product_price
            , product_discount
            , product_total
            , order_header.order_date
            , order_header.due_date
            , order_header.ship_date
            , order_header.order_status
            , order_header.online_order_flag
            , order_header.ship_method_id
            , order_header.order_subtotal
            , order_header.order_tax
            , count(order_header.order_tax) over (partition by order_header.sales_order_id) as tax_by_order_id
            , order_header.order_freight
            , count(order_header.order_freight) over (partition by order_header.sales_order_id) as freight_by_order_id
            , order_header.order_total
            , count(order_header.order_total) over (partition by order_header.sales_order_id) as total_by_order_id
        from order_detail
        left join order_header 
            on order_header.sales_order_id = order_detail.sales_order_id
    )

    , final_cte_orders as (
        select
            sk_customer
            , sk_employee
            , sk_address
            , sk_payment
            , sk_sales_reason
            , sk_products
            , sales_order_id
            , sales_order_detail_id -- Retain line-item level granularity
            , store_id
            , order_qty
            , product_price
            , product_discount
            , product_total
            , order_date
            , due_date
            , ship_date
            , order_status
            , online_order_flag
            , round((order_tax/tax_by_order_id), 2) as unique_tax
            , round((order_freight/freight_by_order_id), 2) as unique_freight
            , round((order_total/total_by_order_id), 2) as unique_total
        from fct_orders
    )

select *
from final_cte_orders