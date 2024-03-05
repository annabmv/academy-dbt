with 

source as (

    select
        businessentityid as business_entity_id
        , salespersonid as sales_person_id
        , name
        , demographics
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'store') }}

)

select * from source
