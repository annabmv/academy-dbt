with
    product as(
        select
            product_id
            , product_sub_category_id
            , product_model_id
            , name as product_name
            , product_number
            , make_flag
            , finished_goods_flag
            , color as product_color
            , product_line
            , class as product_class
            , style as product_style
            , safety_stock_level
            , reorder_point
            , standard_cost
            , list_price
            , date(modified_date) as modified_date
        from{{ ref('stg_product')}}
    )

    , product_sub_category as (
        select
            product_sub_category_id
            , product_category_id
            , name as sub_category_name
            , date(modified_date) as modified_date
        from{{ ref('stg_productsubcategory')}}
    )

    , product_category as (
        select
            product_category_id
            , name as category_name
            , date(modified_date) as modified_date
        from{{ ref('stg_productcategory')}}
    )

    , int_products as (
        select
            product.product_id
            , product.product_name
            , product.product_number
            , product_sub_category.sub_category_name
            , product_category.category_name
            , product.make_flag
            , product.product_color
            , product.product_line
            , product.product_class
            , product.product_style
            , standard_cost
            , list_price
        from product
        left join product_sub_category 
            on product.product_sub_category_id = product_sub_category.product_sub_category_id
        left join product_category 
            on product_sub_category.product_category_id = product_category.product_category_id
    )

select *
from int_products
