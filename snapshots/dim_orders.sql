

{% snapshot orders_snap %}
    {{
        config(
            target_schema='analytics',
            target_database='kyoung',
            unique_key='ID',
            strategy='timestamp',
            invalidate_hard_deletes=False,
            updated_at='_ETL_LOADED_AT'
        )
    }}

    select * from {{ source('jaffle_shop', 'orders') }}
 {% endsnapshot %}

