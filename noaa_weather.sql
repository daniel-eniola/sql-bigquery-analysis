-- Dataset: bigquery-public-data.noaa_gsod.gsod2020 (public dataset)
-- The cleaned output of query 5 was saved as demos.nyc_weather (my own project), and queries 6 and 7 read from it.

-- 5. NOAA Weather: Daily weather for La Guardia and JFK, 2020 (cleaned)
-- Source: bigquery-public-data.noaa_gsod.gsod2020 (NOAA Global Summary of the Day).
-- Stations: 725030 = La Guardia, 744860 = JFK.
-- NOAA uses placeholder values when a measurement is missing (9999.9 for temp,
-- "999.9" for wind speed, 99.99 for precipitation). The IF() calls convert these:
--   temp and wind speed -> NULL, so they don't distort averages
--   precipitation       -> 0
-- wdsp is stored as a string, so it is CAST to FLOAT64 after the check.
-- Sorted newest date first, then by station ID ascending.
-- Result: 732 rows (366 days x 2 stations). Scans ~146 MB per run.
SELECT
 stn,
 date,
 IF(temp = 9999.9, NULL, temp) AS temperature,
 IF(wdsp = "999.9", NULL, CAST(wdsp AS FLOAT64)) AS wind_speed,
 IF(prcp = 99.99, 0, prcp) AS precipitation
FROM
 `bigquery-public-data.noaa_gsod.gsod2020`
WHERE
 stn = "725030" -- La Guardia
 OR stn = "744860" -- JFK
ORDER BY
 date DESC,
 stn ASC;

-- 6. NOAA Weather: Average temperature in June 2020
-- Uses the saved demos.nyc_weather table instead of the large public dataset.
-- AVG ignores NULLs, so missing readings cleaned earlier don't skew the result.
-- Averages both stations combined (30 days x 2 stations).
-- Result: about 72.88 (degrees Fahrenheit).
SELECT
 AVG(temperature) AS avg_temperature_june_2020
FROM
 `project-cc781377-6842-4add-a3a.demos.nyc_weather`
WHERE
 date BETWEEN '2020-06-01' AND '2020-06-30';

-- 7. NOAA Weather: Average wind speed in December 2020
-- Uses the saved demos.nyc_weather table (La Guardia + JFK combined).
-- AVG ignores NULLs, so missing wind readings cleaned earlier don't skew the result.
-- Result: about 11.08 (NOAA GSOD wind speed is in knots).
SELECT
 AVG(wind_speed) AS avg_wind_speed_december_2020
FROM
 `project-cc781377-6842-4add-a3a.demos.nyc_weather`
WHERE
 date BETWEEN '2020-12-01' AND '2020-12-31';
