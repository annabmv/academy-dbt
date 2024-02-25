with
    dim_address as (
        select 
            {{ dbt_utils.generate_surrogate_key(['address_id', 'address_line_1', 'city']) }} as sk_address
            , *
        from{{ ref('int_address')}}
    )

select *
from dim_address