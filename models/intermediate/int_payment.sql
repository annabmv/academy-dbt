with
    credit_card as (
        select
            credit_card_id
            , card_type
            , date(modified_date) as modified_date
        from{{ ref('stg_creditcard')}}
    )

    , person_credit_card as (
        select
            business_entity_id
            , credit_card_id
            , date(modified_date) as modified_date
        from{{ ref('stg_personcreditcard')}}
    )

    , int_payment as (
        select
            credit_card.credit_card_id
            , person_credit_card.business_entity_id
            , credit_card.card_type
            from credit_card
            left join person_credit_card
                on credit_card.credit_card_id = person_credit_card.credit_card_id
    )

select *
from int_payment
