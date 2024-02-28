with 
    fct_orders as (
        select
            int_order_detail.sales_order_id
            , int_order_detail.sales_order_detail_id
            , int_order_detail.sk_products
            , int_order_detail.order_qty
            , int_order_detail.product_price
            , int_order_detail.product_discount
            , int_order_detail.product_total
            , int_order_header.sk_customer
            , int_order_header.sk_employee
            , int_order_header.sk_address
            , int_order_header.sk_payment
            , int_order_header.sk_sales_reason
            , int_order_header.order_date
            , int_order_header.due_date
            , int_order_header.ship_date
            , int_order_header.order_status
            , int_order_header.online_order_flag
            , int_order_header.ship_method_id
            , int_order_header.order_subtotal
            , int_order_header.order_tax
            , int_order_header.order_freight
            , int_order_header.order_total
        from {{ ref('int_order_detail') }}
        join {{ ref('int_order_header') }} 
            on int_order_header.sales_order_id = int_order_detail.sales_order_id
    )

select
    sk_customer
    , sk_employee
    , sk_address
    , sk_payment
    , sk_sales_reason
    , sk_products
    , sales_order_id
    , sales_order_detail_id as item_id -- Retain line-item level granularity
    , order_qty
    , product_price
    , product_discount
    , product_total
    , order_date
    , due_date
    , ship_date
    , order_status
    , online_order_flag
    , order_subtotal
    , order_tax
    , order_freight
    , order_total
from fct_orders
