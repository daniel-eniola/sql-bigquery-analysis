-- Datasets: bigquery-public-data.new_york and bigquery-public-data.austin_bikeshare (public datasets)

-- 38. Count the Citi Bike trips that lasted an hour or more
-- WITH creates a temporary table called trips_over_1_hr that only exists while this query runs.
-- It keeps the trips where tripduration >= 3600 (tripduration is in seconds, so 3600 is 1 hour).
-- The main SELECT then counts the rows in it with COUNT(*). Returned 373,547.
WITH trips_over_1_hr AS (
 SELECT *
 FROM `bigquery-public-data.new_york.citibike_trips`
 WHERE tripduration >= 3600
)
SELECT
 COUNT(*) AS trips_over_1_hr_count
FROM
 trips_over_1_hr;

-- 39. Find the station where the longest-used bike starts most often
-- A temporary table finds the bike with the most total minutes, by adding up duration_minutes for each bike_id.
-- INNER JOIN keeps only that bike's trips, then GROUP BY start_station_id counts the trips per station.
-- ORDER BY trip_ct DESC with LIMIT 1 gives the top station: 3798, with 414 trips.
WITH
 longest_used_bike as (
 SELECT
 bike_id,
 SUM(duration_minutes) AS trip_duration
 FROM
 bigquery-public-data.austin_bikeshare.bikeshare_trips
 GROUP BY
 bike_id
 ORDER BY
 trip_duration DESC
 LIMIT 1
 )

SELECT
 trips.start_station_id,
 COUNT(*) AS trip_ct
FROM
 longest_used_bike AS longest
INNER JOIN
 bigquery-public-data.austin_bikeshare.bikeshare_trips AS trips
ON longest.bike_id = trips.bike_id
GROUP BY
 trips.start_station_id
ORDER BY
 trip_ct DESC
LIMIT 1;
