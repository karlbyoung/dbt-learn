with pay as
(
    select
        order_id
        ,sum(amount) as amount
    from {{ ref('stg_payments')}}
    where status = 'success'
    group by 1
)
select
     ord.order_id
    ,ord.customer_id
    ,ord.order_date
    ,coalesce(pay.amount,0) as amount
from {{ ref('stg_orders')}} ord
left join pay
    on ord.order_id = pay.order_id
