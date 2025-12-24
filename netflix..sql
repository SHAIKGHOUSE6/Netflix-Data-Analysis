use laptop_db;
select * from netflix_titles;
SELECT COUNT(*) AS total_titles
FROM netflix_titles;
SELECT type, COUNT(*) AS count
FROM netflix_titles
GROUP BY type;
SELECT COUNT(*) AS missing_director
FROM netflix_titles
WHERE director IS NULL OR director = '';
SELECT title, COUNT(*)
FROM netflix_titles
GROUP BY title
HAVING COUNT(*) > 1;
SELECT YEAR(date_added) AS year_added,
       COUNT(*) AS titles_added
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;
SELECT
  CASE
    WHEN YEAR(date_added) < 2016 THEN 'Before 2016'
    ELSE 'After 2016'
  END AS period,
  COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY period;
SELECT country, COUNT(*) AS title_count
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY title_count DESC
LIMIT 10;
SELECT country, type, COUNT(*) AS count
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country, type
ORDER BY country, count DESC;
SELECT rating, COUNT(*) AS count
FROM netflix_titles
GROUP BY rating
ORDER BY count DESC;
SELECT
  CASE
    WHEN rating IN ('TV-MA','R','NC-17') THEN 'Adult'
    ELSE 'Family/General'
  END AS audience_type,
  COUNT(*) AS titles
FROM netflix_titles
GROUP BY audience_type;
SELECT
  ROUND(AVG(CAST(REPLACE(duration,' min','') AS UNSIGNED)), 1) AS avg_movie_minutes
FROM netflix_titles
WHERE type = 'Movie';
SELECT duration, COUNT(*) AS count
FROM netflix_titles
WHERE type = 'TV Show'
GROUP BY duration
ORDER BY count DESC;

SELECT
  country,
  COUNT(*) AS titles,
  ROUND(
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles),
    2
  ) AS percentage_share
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY titles DESC
LIMIT 5;
SELECT
  YEAR(date_added) - release_year AS release_gap,
  COUNT(*) AS titles
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY release_gap
ORDER BY release_gap;
