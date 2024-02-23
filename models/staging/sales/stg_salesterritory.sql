with 

source as (

    select
        territoryid as territory_id
        , countryregioncode as country_region_code
        , name
        , "group" as geo_area
        , salesytd as sales_ytd
        , saleslastyear as sales_last_year
        , costytd as cost_ytd
        , costlastyear as cost_last_year
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'salesterritory') }}

)

select * from source
