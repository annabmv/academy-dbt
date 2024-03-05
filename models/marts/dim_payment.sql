with
    dim_payment as (
        select 
            {{ dbt_utils.generate_surrogate_key(['credit_card_id', 'business_entity_id']) }} as sk_payment
            , *
        from{{ ref('int_payment')}}
    )

select *
from dim_payment