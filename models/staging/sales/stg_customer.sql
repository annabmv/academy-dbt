with 

source as (

    select
        customerid as customer_id
        , personid as person_id
        , storeid as store_id
        , territoryid as territory_id
        , modifieddate as modified_date
        , rowguid 
    from {{ source('sap_adw', 'customer') }}

)

select * from source
