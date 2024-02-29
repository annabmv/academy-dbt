with
    customer as (
        select
            customer_id
            , person_id
            , store_id
            , territory_id
            , date(modified_date) as modified_date
        from{{ ref('stg_customer')}}
    )

    , person as (
        select
            business_entity_id
            , person_type
            , first_name
            , middle_name
            , last_name
            , ifnull(concat(first_name, ' '), '') || ifnull(concat(middle_name, ' '), '') || last_name as full_name
            , email_promotion
            , date(modified_date) as modified_date
        from{{ ref('stg_person')}}
    )

    , int_customer as (
        select
            customer_id
            , person.business_entity_id
            , store_id
            , case
                when person.person_type = 'SC' then 'Store Contact'
                when person.person_type = 'IN' then 'Individual Customer'
                when person.person_type = 'SP' then 'Sales Person'
                when person.person_type = 'EM' then 'Employee (non-sales)'
                when person.person_type = 'VC' then 'Vendor Contact'
                when person.person_type = 'GC' then 'General Contact'
            end as person_type
            , person.first_name
            , person.middle_name
            , person.last_name
            , person.full_name
            , person.email_promotion
            from customer
            left join person
                on customer.person_id = person.business_entity_id
    )

select *
from int_customer