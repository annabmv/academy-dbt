with 

source as (

    select
        productcategoryid as product_category_id
        , name
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'productcategory') }}

)

select * from source
