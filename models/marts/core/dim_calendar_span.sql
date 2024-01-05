with
    business_days_only as (
        select * from {{ ref("dim_calendar") }} where is_business_day
    ),
    numbered_days as (
        select
            t1.*,
            lag(t2.row_number) ignore nulls over (
                order by t1.raw_date
            ) as biz_row_number
        from {{ ref("dim_calendar") }} t1
        left join business_days_only t2 on t1.raw_date = t2.raw_date
    ),
    add_days as (
        select
            t1.raw_date,
            t2.biz_row_number - t1.biz_row_number bizdays,
            t2.raw_date land_date
        from numbered_days t1
        join
            numbered_days t2
            on t2.raw_date > t1.raw_date
            and bizdays between 1 and 250
            and t2.is_business_day
    ),
    sub_days as (
        select
            t1.raw_date,
            t2.biz_row_number - t1.biz_row_number bizdays,
            t2.raw_date land_date
        from numbered_days t1
        join
            numbered_days t2
            on t2.raw_date < t1.raw_date
            and bizdays between -30 and -1
            and t2.is_business_day
    ),
    next_biz_day as (
        select
            t.raw_date,
            0 bizdays,
            iff(t.is_business_day, t1.land_date, tnext.land_date) land_date
        from numbered_days t
        join add_days t1 on t.raw_date = t1.raw_date and t1.bizdays = 1
        join sub_days tnext on t1.land_date = tnext.raw_date and tnext.bizdays = -1
    ),
    all_days as (
        select *
        from add_days
        union
        select *
        from sub_days
        union
        select *
        from next_biz_day
    )
select *
from all_days
order by raw_date, bizdays
