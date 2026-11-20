-- Dataset: bigquery-public-data.world_bank_intl_education (public dataset), tables: international_education and country_summary
-- Join key: country_code

-- 12. Join education data to country details, matching rows on country_code
-- INNER JOIN keeps only the rows that match in both tables. Returned 5,080,415 rows.
-- The full table path is repeated each time, which makes the query long.
SELECT
 `bigquery-public-data.world_bank_intl_education.international_education`.country_name,
 `bigquery-public-data.world_bank_intl_education.country_summary`.country_code,
 `bigquery-public-data.world_bank_intl_education.international_education`.value
FROM
 `bigquery-public-data.world_bank_intl_education.international_education`
INNER JOIN
 `bigquery-public-data.world_bank_intl_education.country_summary`
ON
 `bigquery-public-data.world_bank_intl_education.country_summary`.country_code = `bigquery-public-data.world_bank_intl_education.international_education`.country_code;

-- 13. Join education data to country details, using table aliases
-- AS gives each table a short name (edu and summary), so the columns are shorter to write and easier to read.
-- Returned 5,080,415 rows.
SELECT
 edu.country_name,
 summary.country_code,
 edu.value
FROM
 `bigquery-public-data.world_bank_intl_education.international_education` AS edu
INNER JOIN
 `bigquery-public-data.world_bank_intl_education.country_summary` AS summary
ON edu.country_code = summary.country_code;

-- 14. Total population of official secondary school age in 2015, by region
-- Joins on country_code, keeps rows that have a region, and filters to one indicator and one year.
-- SUM adds up value for each region, and ORDER BY puts the largest region first. Returned 7 regions.
SELECT
 summary.region,
 SUM(edu.value) AS secondary_edu_population
FROM
 `bigquery-public-data.world_bank_intl_education.international_education` AS edu
INNER JOIN
 `bigquery-public-data.world_bank_intl_education.country_summary` AS summary
ON edu.country_code = summary.country_code
WHERE summary.region IS NOT NULL
AND edu.indicator_name = 'Population of the official age for secondary education, both sexes (number)'
AND edu.year = 2015
GROUP BY summary.region
ORDER BY secondary_edu_population DESC;
