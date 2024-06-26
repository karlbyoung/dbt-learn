{{ dbt_utils.date_spine(
        datepart = "day",
        start_date="to_date('2010-01-01')",
        end_date="to_date('2071-01-01')"
)}}