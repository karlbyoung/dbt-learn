{% set pay_methods = ['credit_card','coupon','bank_transfer','gift_card'] -%}

with payments as
(
    select * from {{ ref('stg_payments') }}
)
,final as
(
    select
        order_id,
        {%- for pay_method in pay_methods %}
        sum(case when payment_method = '{{pay_method}}' then amount else 0 end) as {{pay_method}}_amount
            {%- if not loop.last %} , {%- endif %}
        {%- endfor %}
    from payments
    where status = 'success'
    group by 1
)
select * from final