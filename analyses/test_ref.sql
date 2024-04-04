with payments as (
    select * from {{ ref('stg_payments') }}
),

total_rev as (
  select
    sum(amount) as total_revenue
    from payments
    where status = 'success'
),

pmt_rev as (
  select
    p.*,tr.total_revenue,round(p.amount/tr.total_revenue*100,1) pct
  from payments p
    join total_rev tr
    on 1=1
  where p.status = 'success'
)

select * from pmt_rev

