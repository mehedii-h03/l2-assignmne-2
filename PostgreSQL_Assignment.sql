-- Problem 1
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT count(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- Problem 3
SELECT * FROM sightings WHERE location ILIKE '%pass%';

-- Problem 4
SELECT
    rangers.name AS ranger_name,
    COUNT(sightings.sighting_id) AS total_sightings
FROM rangers
    LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY
    rangers.name;

-- Problem 5
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT species_id
        FROM sightings
    );

-- Problem 6
SELECT species.common_name, sightings.sighting_time, rangers.name
FROM
    sightings
    JOIN species ON sightings.species_id = species.species_id
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';

-- Problem 8
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 12 AND 16  THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- Problem 9
DELETE FROM rangers
WHERE
    NOT EXISTS (
        SELECT 1
        FROM sightings
        WHERE
            sightings.ranger_id = rangers.ranger_id
    );