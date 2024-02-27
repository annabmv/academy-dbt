with
    order_detail as (
        select
            sales_order_id
            , sales_order_detail_id
            , carrier_tracking_number
            , order_qty
            , product_id
            , special_offer_id
            , unit_price
            , unit_price_discount
            , date(modified_date) as modified_date
        from {{ref('stg_salesorderdetail')}}
    )

    , products as (
        select
            sk_products
            , product_id
            , product_name
            , product_number
            , sub_category_name
            , category_name
            , make_flag
            , product_color
            , product_line
            , product_class
            , product_style
        from {{ref('dim_products')}}
    )

    , int_order_detail as (
        select
            order_detail.sales_order_id
            , order_detail.sales_order_detail_id
            , products.sk_products
            , order_detail.order_qty
            , round(order_detail.unit_price, 2) as product_price
            , round(order_detail.unit_price_discount, 2) as product_discount
            , round(coalesce((order_detail.unit_price * (1.0 - coalesce(order_detail.unit_price_discount, 0.0)) * order_detail.order_qty), 0.0), 2) as product_total
        from {{ref('stg_salesorderdetail')}} as order_detail  
        left join products
            on order_detail.product_id = products.product_id
    )

select *
from int_order_detail