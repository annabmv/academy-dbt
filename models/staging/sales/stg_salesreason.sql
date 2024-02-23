with 

source as (

    select
        salesreasonid as sales_reason_id
        , name
        , reasontype as reason_type
        , modifieddate as modified_date
    from {{ source('sap_adw', 'salesreason') }}

)

select * from source
