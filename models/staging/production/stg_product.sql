with 

source as (

    select
        productid as product_id
        , name
        , productnumber as product_number
        , makeflag as make_flag
        , finishedgoodsflag as finished_goods_flag
        , color
        , safetystocklevel as safety_stock_level
        , reorderpoint as reorder_point
        , standardcost as standard_cost
        , listprice as list_price
        , size
        , sizeunitmeasurecode as size_unit_measure_code
        , weightunitmeasurecode as weight_unit_measure_code
        , weight
        , daystomanufacture as days_to_manufacture
        , productline as product_line
        , class
        , style
        , productsubcategoryid as product_sub_category_id
        , productmodelid as product_model_id
        , sellstartdate as sell_start_date
        , sellenddate as sell_end_date
        , discontinueddate as discontinued_date
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'product') }}

)

select * from source
