-- Dataset: bigquery-public-data.new_york (public dataset), tables: citibike_stations and citibike_trips

-- 25. Show each station's bikes available next to the average for all stations
-- The subquery inside the brackets works out the average. It becomes a new column, avg_num_bikes_available.
-- Returned 1,845 rows.
SELECT
 station_id,
 num_bikes_available,
 (SELECT
   AVG(num_bikes_available)
  FROM `bigquery-public-data.new_york.citibike_stations`) AS avg_num_bikes_available
FROM `bigquery-public-data.new_york.citibike_stations`;

-- 26. Count the rides that started at each station, with the station name
-- The subquery inside the brackets counts the rides for each start station. It is then joined to the stations table to get the names.
-- CAST makes both IDs the same type so they match. Returned 508 rows.
SELECT
 station_id,
 name,
 number_of_rides AS number_of_rides_starting_at_station
FROM
 (
  SELECT
   CAST(start_station_id AS STRING) AS start_station_id_str,
   COUNT(*) AS number_of_rides
  FROM
   `bigquery-public-data.new_york.citibike_trips`
  GROUP BY
   CAST(start_station_id AS STRING)
 )
AS station_num_trips
INNER JOIN
 `bigquery-public-data.new_york.citibike_stations`
ON
 station_id = start_station_id_str
ORDER BY
 number_of_rides DESC;

-- 27. Stations where subscribers started a trip
-- The subquery inside the brackets builds a list of the stations subscribers started from.
-- IN keeps a station only if its station_id is in that list. Returned 508 rows.
SELECT
 station_id,
 name
FROM
 `bigquery-public-data.new_york.citibike_stations`
WHERE
 station_id IN
 (
  SELECT
   CAST(start_station_id AS STRING) AS start_station_id_str
  FROM
   `bigquery-public-data.new_york.citibike_trips`
  WHERE
   usertype = 'Subscriber'
 );
