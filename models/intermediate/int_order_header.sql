with
    customer as (
        select
            sk_customer
            , customer_id
        from {{ref('dim_customer')}}
    )

    , sales_person as (
        select
            sk_employee
            , business_entity_id
        from {{ref('dim_employee')}}
    )

    , address as (
        select
            sk_address
            , address_id
        from {{ref('dim_address')}}
    )

    , credit_card as (
        select
           sk_payment
            , credit_card_id
        from {{ref('dim_payment')}} 
    )

    , sales_reason as (
        select
            sk_sales_reason
            , sales_order_id
        from {{ref('dim_sales_reason')}}
    )

    , order_header as (
        select
            sales_order_id
            , revision_number
            , date(order_date) as order_date
            , date(due_date) as due_date
            , date(ship_date) as ship_date
            , case
                when status = 1 then 'In process'
                when status = 2 then 'Approved'
                when status = 3 then 'Backordered'
                when status = 4 then 'Rejected'
                when status = 5 then 'Shipped'
                when status = 6 then 'Cancelled' 
            end as order_status 
            , online_order_flag
            , purchase_order_number
            , account_number
            , customer_id
            , sales_person_id
            , territory_id
            , bill_to_address_id
            , ship_to_address_id
            , ship_method_id
            , credit_card_id
            , round(subtotal, 2) as subtotal
            , round(taxamt, 2) as taxamt
            , round(freight, 2) as freight
            , round(total_due, 2) as total_due
            , date(modified_date) as modified_date
        from {{ref('stg_salesorderheader')}}
    )

    , int_order_header as (
        select
            customer.sk_customer
            , sales_person.sk_employee
            , address.sk_address
            , credit_card.sk_payment
            , sales_reason.sk_sales_reason
            , order_header.sales_order_id
            , order_header.order_date
            , order_header.due_date
            , order_header.ship_date
            , order_header.order_status
            , order_header.online_order_flag
            , order_header.ship_method_id
            , order_header.subtotal as order_subtotal
            , order_header.taxamt as order_tax
            , order_header.freight as order_freight
            , order_header.total_due as order_total
        from order_header 
        left join customer
            on order_header.customer_id = customer.customer_id
        left join sales_person
            on order_header.sales_person_id = sales_person.business_entity_id
        left join address
            on order_header.bill_to_address_id = address.address_id
        left join credit_card
            on order_header.credit_card_id = credit_card.credit_card_id
        left join sales_reason
            on order_header.sales_order_id = sales_reason.sales_order_id
    )

select *
from int_order_header