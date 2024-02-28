with
    dim_sales_reason as (
        select 
            {{ dbt_utils.generate_surrogate_key(['sales_order_id']) }} as sk_sales_reason
            , *
        from{{ ref('int_sales_reason')}}
    )

select *
from dim_sales_reason