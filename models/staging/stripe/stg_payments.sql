select 
    orderid as order_id
    ,paymentmethod as payment_method
    ,amount/100.0 as amount
    ,status
  from raw.stripe.payment