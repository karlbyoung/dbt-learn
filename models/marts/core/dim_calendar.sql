WITH  dates AS
(
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2010-01-01' as date)",
        end_date="cast('2051-01-01' as date)"
       )
    }}

)
, date_info AS
(
    SELECT ROW_NUMBER() over (order by date_day) AS "ROW_NUMBER"
        ,date_day AS "RAW_DATE"
        ,dayofweek(RAW_DATE) "DAY_OF_WEEK"
        ,dayname(RAW_DATE) "DAY_NAME"
        ,h.HOLIDAY
        ,IFF(DAY_NAME IN ('Sat','Sun'), TRUE, FALSE) AS "IS_WEEKEND"
        ,IFF(h.HOLIDAY IS NOT NULL, TRUE, FALSE) AS "IS_HOLIDAY"
        ,NOT (IS_WEEKEND OR IS_HOLIDAY) AS IS_BUSINESS_DAY
    FROM dates
    LEFT JOIN {{ref ('holidays') }} h
            ON h.OUT_OF_OFFICE = RAW_DATE
    ORDER BY RAW_DATE
)
select * from date_info