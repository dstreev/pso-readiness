USE dev_102_ext;
-- Query #1: First Toy Story
SELECT count(*) as query_1_count from (
SELECT DISTINCT
    m.title,
    t.tag
FROM
    movies m
JOIN
    tags t
ON
    m.id = t.movieid
WHERE
    m.title like "Toy Story%") temp;
-- Query #2: v1 (2 Stages, 3:1,..) 99 seconds.
-- Prevent MapSide Join.. Otherwise... Good night...
SET hive.auto.convert.join=false;
SELECT DISTINCT
    m.title,
    m.genres,
    r.rating
FROM
    movies m
JOIN
    ratings r
ON
    m.id = r.movieid
WHERE
    array_contains(m.genres, "Comedy")
AND r.rating = 5;

-- Query #2: v2 (2 Stages) 97 seconds.
SET hive.auto.convert.join=false;
SELECT
    m2.*
FROM
    (
        SELECT DISTINCT
            m.title,
            m.genres
        FROM
            movies m
        JOIN
            ratings r
        ON
            m.id = r.movieid
        WHERE
            r.rating = 5) m2
WHERE
    array_contains(m2.genres, "Comedy");
-- Query #2: v3 (3 Stages, 2:1, 2:1, 1:1) 82-87 seconds.
select count(*) as query_2_count from (
SELECT DISTINCT
    m2.title
FROM
    (
        SELECT
            m.id,
            m.title,
            m.genres
        FROM
            movies m
        WHERE
            array_contains(m.genres, "Comedy")) m2
JOIN
    (
        SELECT DISTINCT
            movieid
        FROM
            ratings
        WHERE
            rating = 5) r2
ON
    m2.id = r2.movieid) temp;
    
-- Query #3: v1 (4 Stages, 2:1, 2:1, 1:1, 2:1) 109 seconds.
SELECT
    count(*) as query_3_count
    --m3.id,
    --m3.title,
    --t.tag,
    --from_unixtime(t.ts)
FROM
    (
        SELECT DISTINCT
            m2.id,
            m2.title
        FROM
            (
                SELECT
                    m.id,
                    m.title,
                    m.genres
                FROM
                    movies m
                WHERE
                    array_contains(m.genres, "Comedy")) m2
       JOIN
            (
                SELECT DISTINCT
                    movieid
                FROM
                    ratings
                WHERE
                    rating = 5) r2
        ON
            m2.id = r2.movieid) m3
JOIN
    tags t
ON
    m3.id = t.movieid;