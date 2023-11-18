{{ config (
    materialized="table"
)}}

with seq AS
(
    select * from {{ ref('all_days')}}
)
  SELECT datediff('day','2000-01-01',seq.date_day)+1 AS "ROW_NUMBER" 
         ,date_day raw_date
         ,dayofweek(RAW_DATE) "DAY_OF_WEEK"
         ,dayname(RAW_DATE) "DAY_NAME"
--         ,h.HOLIDAY
         ,IFF(DAY_NAME IN ('Sat','Sun'), TRUE, FALSE) AS "IS_WEEKEND"
--         ,IFF(h.HOLIDAY IS NOT NULL, TRUE, FALSE) AS "IS_HOLIDAY"
  FROM seq
