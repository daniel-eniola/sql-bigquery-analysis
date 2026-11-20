-- Dataset: bigquery-public-data.ncaa_basketball (public dataset), tables: mbb_historical_teams_seasons and mascots

-- 15. Average wins, losses and ties for Division 1 teams in the 1990s, with their mascots (LEFT JOIN)
-- LEFT JOIN keeps every team from the seasons table, even one with no mascot. GROUP BY 1, 2, 3 (university, team_name, team_mascot) gives one averaged row per team.
-- Teams with the highest average wins come first. Returned 320 rows.
SELECT
 seasons.market AS university,
 seasons.name AS team_name,
 mascots.mascot AS team_mascot,
 AVG(seasons.wins) AS avg_wins,
 AVG(seasons.losses) AS avg_losses,
 AVG(seasons.ties) AS avg_ties
FROM `bigquery-public-data.ncaa_basketball.mbb_historical_teams_seasons` AS seasons
LEFT JOIN `bigquery-public-data.ncaa_basketball.mascots` AS mascots
ON seasons.team_id = mascots.id
WHERE seasons.season BETWEEN 1990 AND 1999
 AND seasons.division = 1
GROUP BY 1, 2, 3
ORDER BY
 avg_wins DESC,
 university;

-- 16. Same query with INNER JOIN instead of LEFT JOIN
-- INNER JOIN drops the teams that have no matching mascot, so it returned 317 rows instead of 320.
SELECT
 seasons.market AS university,
 seasons.name AS team_name,
 mascots.mascot AS team_mascot,
 AVG(seasons.wins) AS avg_wins,
 AVG(seasons.losses) AS avg_losses,
 AVG(seasons.ties) AS avg_ties
FROM `bigquery-public-data.ncaa_basketball.mbb_historical_teams_seasons` AS seasons
INNER JOIN `bigquery-public-data.ncaa_basketball.mascots` AS mascots
ON seasons.team_id = mascots.id
WHERE seasons.season BETWEEN 1990 AND 1999
 AND seasons.division = 1
GROUP BY 1, 2, 3
ORDER BY
 avg_wins DESC,
 university;
