{{ dbt_utils.date_spine(
        datepart = "day",
        start_date="to_date('2000-01-01')",
        end_date="to_date('2051-01-01')"
)}}