with
    order_sales_reason as(
        select
            sales_order_id
            , sales_reason_id
            , date(modified_date) as modified_date
        from{{ ref('stg_salesorderheadersalesreason')}}
    )

    , sales_reason as(
        select
            sales_reason_id
            , name as reason_name
            , reason_type
            , date(modified_date) as modified_date
        from{{ ref('stg_salesreason')}}
    )

    , int_sales_reason as (
    select
        order_sales_reason.sales_order_id
        , string_agg(sales_reason.reason_name, ', ') as reason_names -- concatenates all reason names associated with an order
        , string_agg(sales_reason.reason_type, ', ') as reason_types -- concatenates all reason types associated with an order
    from order_sales_reason
    left join sales_reason 
        on order_sales_reason.sales_reason_id = sales_reason.sales_reason_id
    group by order_sales_reason.sales_order_id
)

select *
from int_sales_reason