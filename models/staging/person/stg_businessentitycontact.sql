with 

source as (

    select
        businessentityid as business_entity_id
        , personid as person_id
        , contacttypeid as contact_type_id
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'businessentitycontact') }}

)

select * from source
