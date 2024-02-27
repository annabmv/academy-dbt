with
    address as (
        select
            address_id
            , state_province_id
            , address_line_1 as address_line
            , city
            , date(modified_date) as modified_date
        from{{ ref('stg_address')}}
    )

    , state_province as (
        select
            state_province_id
            , territory_id
            , state_province_code
            , country_region_code
            , name as state_name
            , date(modified_date) as modified_date
        from{{ ref('stg_stateprovince')}}
    )

    , country_region as (
        select
            country_region_code
            , name as country_name
            , date(modified_date) as modified_date
        from{{ ref('stg_countryregion')}}
    )

    , territory as (
        select
            territory_id
            , country_region_code
            , name as territory_name
        from{{ ref('stg_salesterritory')}}
    )

    , int_address as (
        select
            address.address_id
            , address.state_province_id
            , territory.territory_name
            , address.address_line
            , address.city
            , state_province.state_province_code
            , state_province.country_region_code
            , state_province.state_name
            , country_region.country_name
            from address
            left join state_province
                on address.state_province_id = state_province.state_province_id
            left join country_region
                on state_province.country_region_code = country_region.country_region_code
            left join territory
                on state_province.territory_id = territory.territory_id
    )

select *
from int_address