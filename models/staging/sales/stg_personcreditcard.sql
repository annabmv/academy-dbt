with 

source as (

    select
        businessentityid as business_entity_id
        , creditcardid as credit_card_id
        , modifieddate as modified_date
    from {{ source('sap_adw', 'personcreditcard') }}

)

select * from source
