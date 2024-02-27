with
    dim_customer as (
        select 
            {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as sk_customer
            , *
        from{{ ref('int_customer')}}
    )

select *
from dim_customer