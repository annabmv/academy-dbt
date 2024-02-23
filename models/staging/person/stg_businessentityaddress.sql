with 

source as (

    select
        businessentityid as business_entity_id
        , addressid as address_id
        , addresstypeid as address_type_id
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'businessentityaddress') }}

)

select * from source
