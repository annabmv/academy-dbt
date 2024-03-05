with
    dim_address as (
        select 
            {{ dbt_utils.generate_surrogate_key(['address_id', 'state_province_id']) }} as sk_address
            , *
        from{{ ref('int_address')}}
    )

select *
from dim_address