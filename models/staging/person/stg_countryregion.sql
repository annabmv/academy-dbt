with 

source as (

    select
        countryregioncode as country_region_code
        , name
        , modifieddate as modified_date
    from {{ source('sap_adw', 'countryregion') }}

)

select * from source
