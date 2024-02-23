with 

source as (

    select
        addresstypeid as address_type_id
        , name
        , rowguid
        , modifieddate as modified_date
    from {{ source('sap_adw', 'addresstype') }}

)

select * from source
