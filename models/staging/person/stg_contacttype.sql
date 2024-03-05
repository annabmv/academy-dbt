with 

source as (

    select
        contacttypeid as contact_type_id
        , name
        , modifieddate as modified_date
    from {{ source('sap_adw', 'contacttype') }}

)

select * from source
