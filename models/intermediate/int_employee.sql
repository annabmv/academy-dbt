with
    sales_person as (
        select
            business_entity_id
            , territory_id
            , date(modified_date) as modified_date
        from{{ ref('stg_salesperson')}}
    )

    , employee as (
        select
            business_entity_id
            , job_title
            , date(modified_date) as modified_date
        from{{ ref('stg_employee')}}
    )

    , person as (
        select
            business_entity_id
            , person_type
            , first_name
            , middle_name
            , last_name
            , ifnull(concat(first_name, ' '), '') || ifnull(concat(middle_name, ' '), '') || last_name as full_name
            , date(modified_date) as modified_date
        from{{ ref('stg_person')}}
    )

    , int_employee as (
        select
            sales_person.business_entity_id
            , sales_person.territory_id
            , employee.job_title
            , person.full_name
            from sales_person
            left join employee
                on sales_person.business_entity_id = employee.business_entity_id
            left join person
                on employee.business_entity_id = person.business_entity_id
            where person.person_type = 'SP'
    )

select *
from int_employee
