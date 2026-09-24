SELECT
    COUNT(*) AS total_od_legs,
    COUNT(DISTINCT trip_uuid) AS total_trips,
    ROUND(AVG(time_delay), 2) AS avg_delay_min,
    ROUND(AVG(actual_time), 2) AS avg_actual_time_min,
    ROUND(AVG(osrm_time), 2) AS avg_osrm_time_min,
    ROUND(AVG(actual_distance), 2) AS avg_actual_distance_km,
    ROUND(AVG(osrm_distance), 2) AS avg_osrm_distance_km,
    MIN(time_delay) AS min_delay_min,
    MAX(time_delay) AS max_delay_min
FROM od_leg_analysis;

SELECT
    delay_category,
    COUNT(*) AS od_legs,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM od_leg_analysis),
        2
    ) AS percentage
FROM od_leg_analysis
GROUP BY delay_category
ORDER BY
    CASE delay_category
        WHEN 'Early' THEN 1
        WHEN 'On Time' THEN 2
        WHEN 'Moderate Delay' THEN 3
        WHEN 'High Delay' THEN 4
        WHEN 'Severe Delay' THEN 5
        ELSE 6
    END;
    
    
SELECT
    route_type,
    COUNT(*) AS od_legs,
    ROUND(AVG(time_delay), 2) AS avg_delay,
    ROUND(
        AVG(CASE WHEN delay_category = 'Severe Delay' THEN 1 ELSE 0 END) * 100,
        2
    ) AS severe_delay_pct,
    ROUND(AVG(actual_distance), 2) AS avg_actual_distance_km,
    ROUND(AVG(osrm_distance), 2) AS avg_osrm_distance_km
FROM od_leg_analysis
GROUP BY route_type
ORDER BY avg_delay DESC;


SELECT
    distance_band,
    COUNT(*) AS od_legs,
    ROUND(AVG(time_delay), 2) AS avg_delay,
    ROUND(
        AVG(CASE WHEN delay_category = 'Severe Delay' THEN 1 ELSE 0 END) * 100,
        2
    ) AS severe_delay_pct,
    ROUND(AVG(actual_distance), 2) AS avg_actual_distance_km
FROM od_leg_analysis
GROUP BY distance_band
ORDER BY
    CASE distance_band
        WHEN '0–25 km' THEN 1
        WHEN '25–50 km' THEN 2
        WHEN '50–100 km' THEN 3
        WHEN '100–200 km' THEN 4
        WHEN '200+ km' THEN 5
        ELSE 6
    END;
    
SELECT
    source_center,
    source_name,
    COUNT(*) AS od_legs,
    ROUND(AVG(time_delay), 2) AS avg_delay,
    ROUND(
        AVG(CASE
            WHEN delay_category = 'Severe Delay' THEN 1
            ELSE 0
        END) * 100,
        2
    ) AS severe_delay_pct
FROM od_leg_analysis
GROUP BY source_center, source_name
HAVING COUNT(*) >= 30
ORDER BY avg_delay DESC
LIMIT 10;

SELECT
    destination_center,
    destination_name,
    COUNT(*) AS od_legs,
    ROUND(AVG(time_delay), 2) AS avg_delay,
    ROUND(
        AVG(CASE
            WHEN delay_category = 'Severe Delay' THEN 1
            ELSE 0
        END) * 100,
        2
    ) AS severe_delay_pct
FROM od_leg_analysis
GROUP BY destination_center, destination_name
HAVING COUNT(*) >= 30
ORDER BY avg_delay DESC
LIMIT 10;


SELECT
    cutoff_initial_status,
    cutoff_final_status,
    COUNT(*) AS od_legs,
    ROUND(AVG(time_delay), 2) AS avg_delay,
    ROUND(
        AVG(CASE
            WHEN delay_category = 'Severe Delay' THEN 1
            ELSE 0
        END) * 100,
        2
    ) AS severe_delay_pct,
    ROUND(AVG(actual_distance), 2) AS avg_distance_km
FROM od_leg_analysis
GROUP BY
    cutoff_initial_status,
    cutoff_final_status
ORDER BY
    cutoff_initial_status,
    cutoff_final_status;
    
SELECT
    route_type,
    COUNT(*) AS od_legs,
    ROUND(AVG(actual_time - osrm_time), 2) AS avg_time_gap_min,
    ROUND(AVG(actual_time / NULLIF(osrm_time, 0)), 2) AS avg_time_ratio,
    ROUND(AVG(distance_gap), 2) AS avg_distance_gap_km
FROM od_leg_analysis
GROUP BY route_type
ORDER BY avg_time_gap_min DESC;


SELECT
    route_type,
    delay_category,
    COUNT(*) AS od_legs,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY route_type),
        2
    ) AS percentage
FROM od_leg_analysis
GROUP BY
    route_type,
    delay_category
ORDER BY
    route_type,
    CASE delay_category
        WHEN 'Early' THEN 1
        WHEN 'On Time' THEN 2
        WHEN 'Moderate Delay' THEN 3
        WHEN 'High Delay' THEN 4
        WHEN 'Severe Delay' THEN 5
        ELSE 6
    END;
    
    
SELECT
    source_name,
    destination_name,
    COUNT(*) AS od_legs,
    ROUND(AVG(time_delay), 2) AS avg_delay,
    ROUND(
        AVG(
            CASE
                WHEN delay_category = 'Severe Delay' THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS severe_delay_pct
FROM od_leg_analysis
GROUP BY
    source_name,
    destination_name
HAVING COUNT(*) >= 20
ORDER BY avg_delay DESC
LIMIT 15;


SELECT
    source_name,
    destination_name,
    COUNT(*) AS od_legs,
    ROUND(AVG(time_delay), 2) AS avg_delay,
    ROUND(
        AVG(
            CASE
                WHEN delay_category = 'Severe Delay' THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS severe_delay_pct
FROM od_leg_analysis
GROUP BY
    source_name,
    destination_name
HAVING COUNT(*) >= 50
ORDER BY avg_delay DESC
LIMIT 15;


SELECT
    COUNT(*) AS total_rows,
    SUM(trip_uuid IS NULL OR trip_uuid = '') AS missing_trip_uuid,
    SUM(source_center IS NULL OR source_center = '') AS missing_source_center,
    SUM(destination_center IS NULL OR destination_center = '') AS missing_destination_center,
    SUM(actual_time < 0) AS negative_actual_time,
    SUM(osrm_time < 0) AS negative_osrm_time,
    SUM(actual_distance < 0) AS negative_actual_distance,
    SUM(osrm_distance < 0) AS negative_osrm_distance
FROM od_leg_analysis;


SELECT
    COUNT(*) AS duplicate_groups
FROM (
    SELECT
        trip_uuid,
        od_start_time,
        od_end_time,
        source_center,
        destination_center,
        COUNT(*) AS cnt
    FROM od_leg_analysis
    GROUP BY
        trip_uuid,
        od_start_time,
        od_end_time,
        source_center,
        destination_center
    HAVING COUNT(*) > 1
) AS duplicates;