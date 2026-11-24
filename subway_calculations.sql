-- Dataset: bigquery-public-data.new_york_subway (public dataset), table: subway_ridership_2013_present

-- 36. Change in ridership between 2013 and 2014 at each station
-- ridership_2014 - ridership_2013 gives how many more (or fewer) riders each station had in 2014.
-- A positive number means more riders, a negative number means fewer. Returned 430 rows.
SELECT
 station_name,
 ridership_2013,
 ridership_2014,
 ridership_2014 - ridership_2013 AS change_2014_raw
FROM
 bigquery-public-data.new_york_subway.subway_ridership_2013_present;

-- 37. Average ridership over 2013 to 2016 for each station
-- The four yearly numbers are added together in brackets, then divided by 4 to get the average.
-- The calculation is done for each row and saved as average_weekly_ridership. Returned 430 rows.
SELECT
 station_name,
 ridership_2013,
 ridership_2014,
 ridership_2015,
 ridership_2016,
 (ridership_2013 + ridership_2014 + ridership_2015 + ridership_2016) / 4 AS average_weekly_ridership
FROM
 bigquery-public-data.new_york_subway.subway_ridership_2013_present;
