-- Dataset: bigquery-public-data.fda_food (public dataset), table: food_events

-- 29. Top 10 food industries by number of reports
-- COUNT counts the reports for each industry. ORDER BY ... DESC puts the biggest first, and LIMIT 10 keeps the top ten.
SELECT
 products_industry_name,
 COUNT(report_number) AS count_reports
FROM bigquery-public-data.fda_food.food_events
GROUP BY products_industry_name
ORDER BY count_reports DESC
LIMIT 10;

-- 30. Hospitalizations in the 10 industries with the most reports
-- The subquery inside the brackets finds those 10 industries, and IN keeps only them. LIKE '%Hospitalization%' keeps reports where the outcome mentions it.
SELECT
 products_industry_name,
 COUNT(report_number) AS count_hospitalizations
FROM
 bigquery-public-data.fda_food.food_events
WHERE products_industry_name IN
 (SELECT
   products_industry_name
  FROM
   bigquery-public-data.fda_food.food_events
  GROUP BY products_industry_name
  ORDER BY COUNT(report_number) DESC LIMIT 10)
AND outcomes LIKE '%Hospitalization%'
GROUP BY products_industry_name
ORDER BY count_hospitalizations DESC;
