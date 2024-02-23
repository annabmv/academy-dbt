with 

source as (

    select
        businessentityid as business_entity_id
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'businessentity') }}

)

select * from source
