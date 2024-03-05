with 

source as (

    select
        businessentityid as business_entity_id
        , nationalidnumber as national_id_number
        , loginid as login_id
        , jobtitle as job_title
        , birthdate as birth_date
        , gender
        , hiredate as hire_date
        , salariedflag as salaried_flag
        , currentflag as current_flag
        , modifieddate as modified_date
        , rowguid
    from {{ source('sap_adw', 'employee') }}

)

select * from source
