-- Dataset: bigquery-public-data.new_york (public dataset), table: citibike_trips

-- 35. Count the Citi Bike rides in each year
-- EXTRACT(YEAR FROM starttime) pulls the year out of the start time of each ride.
-- GROUP BY year then counts the rides for each year with COUNT(*). Returned 4 rows (2013 to 2016).
SELECT
 EXTRACT(YEAR FROM starttime) AS year,
 COUNT(*) AS number_of_rides
FROM
 `bigquery-public-data.new_york.citibike_trips`
GROUP BY
 year
ORDER BY year;
