
{{ dbt_utils.union_relations(
    relations=[ref('dim_customers'), ref('dim_customers')],
    exclude=["_loaded_at"]
) }}
