-- Validate results_master

SELECT COUNT(*) AS total_rows
FROM `project-1-music-489315.Formula_1.results_master`;

SELECT
    COUNT(*) - COUNT(DISTINCT CONCAT(CAST(raceId AS STRING), '-', CAST(driverId AS STRING)))
    AS duplicate_driver_race_rows
FROM `project-1-music-489315.Formula_1.results_master`;

SELECT
    COUNTIF(driver_name IS NULL) AS missing_driver_name,
    COUNTIF(constructor_name IS NULL) AS missing_constructor_name,
    COUNTIF(race_year IS NULL) AS missing_race_year,
    COUNTIF(circuit_name IS NULL) AS missing_circuit_name
FROM `project-1-music-489315.Formula_1.results_master`;