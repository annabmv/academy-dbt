with 

source as (

    select
        productsubcategoryid as product_sub_category_id
        , productcategoryid as product_category_id
        , name
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'productsubcategory') }}

)

select * from source
