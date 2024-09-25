with source_data as
(
    {% if env_var('DBT_ENV_NAME')  == 'development' %}
    select * from {{ ref('stg_orders') }}
    {% else %}
    select * from  {{ ref('stg_orders2') }}
    {% endif %}
)

select * from source_data