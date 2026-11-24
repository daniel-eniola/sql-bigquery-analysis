# BigQuery SQL: Analyzing Data

SQL queries I ran in Google BigQuery while analyzing data: filtering, sorting, cleaning, joining and averaging. Each query has a short comment explaining what it does.

| File | Queries | Dataset |
|---|---|---|
| `movie_data.sql` | #1-4 | `movie_data.movies` (my own project) |
| `noaa_weather.sql` | #5-7 | `bigquery-public-data.noaa_gsod.gsod2020` (public dataset), saved as `demos.nyc_weather` (my own project) |
| `joins.sql` | #8-11 | `employee_data.employees` and `employee_data.departments` (my own project) |
| `world_bank_education.sql` | #12-14 | `bigquery-public-data.world_bank_intl_education` (public dataset) |
| `ncaa_basketball.sql` | #15-16 | `bigquery-public-data.ncaa_basketball` (public dataset) |
| `warehouse_orders.sql` | #17-24, #28 | `warehouse_orders.orders` and `warehouse_orders.warehouse` (my own project) |
| `citibike_subqueries.sql` | #25-27 | `bigquery-public-data.new_york` (public dataset) |
| `fda_food_events.sql` | #29-30 | `bigquery-public-data.fda_food` (public dataset) |
| `avocado_calculations.sql` | #31-34 | `avocado_data.avocado_prices` (my own project) |
| `citibike_calculations.sql` | #35 | `bigquery-public-data.new_york` (public dataset) |
| `subway_calculations.sql` | #36-37 | `bigquery-public-data.new_york_subway` (public dataset) |
| `temporary_tables.sql` | #38-39 | `bigquery-public-data.new_york` and `austin_bikeshare` (public datasets) |

## Skills covered

- Filtering with `WHERE`
- Sorting with `ORDER BY ... DESC`
- Combining conditions with `AND`
- Comparing numbers (`>`)
- Cleaning placeholder values with `IF()` and `CAST`
- `AVG` over a date range with `BETWEEN`
- Combining tables with `INNER`, `LEFT`, `RIGHT` and `FULL OUTER JOIN`
- Table aliases with `AS`
- `SUM` and `AVG` with `GROUP BY` on joined tables
- Choosing `LEFT JOIN` over `INNER JOIN` to keep unmatched rows
- `COUNT` vs `COUNT DISTINCT` on joined tables
- `COUNT DISTINCT` with `GROUP BY` to count orders per state
- Subqueries in the `SELECT`, `FROM` and `WHERE` clauses
- `LIKE` pattern matching combined with a subquery in the `WHERE`
- Labelling rows with `CASE`, and filtering groups with `HAVING`
- Calculations in a `SELECT`: adding columns and working out percentages
- Avoiding "division by zero" with a `WHERE` filter, and `<>` vs `!=`
- `EXTRACT` to pull the year out of a timestamp, with `COUNT` and `GROUP BY`
- Subtracting columns and averaging several columns in a `SELECT`
- Temporary tables with `WITH`, and joining one back to the original table

## Notes

- **Saved table:** the cleaned NOAA output was saved as a table, `demos.nyc_weather`, by creating a dataset called `demos` and using **Save results > BigQuery table**. The averages in `noaa_weather.sql` read from that saved table instead of the large public dataset.
