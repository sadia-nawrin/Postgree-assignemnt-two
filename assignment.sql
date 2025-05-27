-- Active: 1747652597438@@127.0.0.1@5433@conservation_db


CREATE TABLE rangers (
    ranger_id INT  PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50) 
);

CREATE TABLE species (
    species_id INT PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

CREATE TABLE sightings (
    sighting_id INT PRIMARY KEY,
    ranger_id INT,
    species_id INT,
    sighting_time DATE,
    location VARCHAR(50),
    notes TEXT,
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id),
    FOREIGN KEY (species_id) REFERENCES species(species_id)
);




INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range')
;



INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');



INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes)
VALUES 
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);






SELECT*FROM rangers;
SELECT*FROM species;
SELECT*FROM sightings;


-- problem--1
INSERT INTO rangers (ranger_id, name, region) VALUES
(4,'Derek Fox', 'Coastal Plains');
-- problem--1 end


-- problem ---2
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;
-- problem--2 end


-- problem--3
SELECT * FROM sightings
WHERE location LIKE '%Pass%';
-- problem--3 end


-- problem-4

-- problem-4 end




-- problem--5
SELECT common_name
FROM species
WHERE species_id NOT IN (
    SELECT species_id
    FROM sightings
);
-- problem--5 end







-- problem--6
SELECT 
    species.common_name AS species_common_name,
    sightings.sighting_time AS sighting_time,
    rangers.name AS ranger_name
FROM sightings
JOIN species ON sightings.species_id = species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;


-- problem--6 end


-- problem--7
UPDATE species 
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';
-- problem--7 end



-- problem--8
CREATE VIEW sighting_times AS
SELECT
  sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 16 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;
;

SELECT * FROM sighting_times;
-- problem--8 end


-- problem--9
DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);
-- problem--9 end
