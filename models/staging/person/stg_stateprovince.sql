with 

source as (

    select
        stateprovinceid as state_province_id
        , territoryid as territory_id
        , stateprovincecode as state_province_code
        , countryregioncode as country_region_code
        , isonlystateprovinceflag as is_only_state_province_flag
        , name
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'stateprovince') }}

)

select * from source
