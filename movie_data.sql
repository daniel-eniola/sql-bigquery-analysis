-- Dataset: movie_data (my own project), table: movies

-- 1. Movie Data: All comedy movies
-- Filters the movies table to rows where Genre is exactly 'Comedy'.
-- Returns 98 of the 508 movies.
SELECT
 *
FROM
 `project-cc781377-6842-4add-a3a.movie_data.movies`
WHERE
 Genre = 'Comedy';

-- 2. Movie Data: All movies, newest first
-- Returns every movie (508 rows) sorted by Release_Date, latest release at the top.
-- Release_Date is in date format, so sorting it descending gives true date order.
SELECT
 *
FROM
 `project-cc781377-6842-4add-a3a.movie_data.movies`
ORDER BY
 Release_Date DESC;

-- 3. Movie Data: Comedy movies, newest first
-- Combines the Genre filter with the sort by Release_Date from the previous queries.
-- Returns the 98 comedies with the most recent release first.
SELECT
 *
FROM
 `project-cc781377-6842-4add-a3a.movie_data.movies`
WHERE
 Genre = 'Comedy'
ORDER BY
 Release_Date DESC;

-- 4. Movie Data: Blockbuster comedies (revenue over 300 million), newest first
-- Adds a Revenue threshold to the comedy query, so only comedies that grossed more than 300,000,000 are returned. 7 movies match (e.g. The Angry Birds Movie).
-- Revenue is a number (INTEGER), so the comparison works without casting.
SELECT
 *
FROM
 `project-cc781377-6842-4add-a3a.movie_data.movies`
WHERE
 Genre = 'Comedy'
 AND Revenue > 300000000
ORDER BY
 Release_Date DESC;
