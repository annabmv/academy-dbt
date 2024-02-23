with 

source as (

    select
        addressid as address_id
        , stateprovinceid as state_province_id
        , addressline1 as address_line_1
        , addressline2 as address_line_2
        , city
        , postalcode as postal_code
        , spatiallocation as spatial_location
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'address') }}

)

select * from source
