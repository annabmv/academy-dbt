with
    dim_employee as (
        select 
            {{ dbt_utils.generate_surrogate_key(['business_entity_id', 'job_title']) }} as sk_employee
            , *
        from{{ ref('int_employee')}}
    )

select *
from dim_employee