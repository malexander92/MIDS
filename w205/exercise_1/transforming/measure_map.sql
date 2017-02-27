-- creating mapping of measure ids to names
DROP TABLE IF EXISTS measure_map;
CREATE TABLE measure_map AS
SELECT
	measure_id,
	measure_name
FROM measures
GROUP BY measure_id,measure_name
;

INSERT INTO measure_map
SELECT
	a.measure_id,
	a.measure_name
FROM effective_care_hospital a
LEFT OUTER JOIN measure_map b
ON a.measure_id = b.measure_id
AND b.measure_id IS NULL
GROUP BY a.measure_id,a.measure_name
;

INSERT INTO measure_map
SELECT
	a.measure_id,
	a.measure_name
FROM effective_care_state a
LEFT OUTER JOIN measure_map b
ON a.measure_id = b.measure_id
AND b.measure_id IS NULL
GROUP BY a.measure_id,a.measure_name
;

INSERT INTO measure_map
SELECT
	a.measure_id,
	a.measure_name
FROM readmissions_hospital a
LEFT OUTER JOIN measure_map b
ON a.measure_id = b.measure_id
AND b.measure_id IS NULL
GROUP BY a.measure_id,a.measure_name
;

INSERT INTO measure_map
SELECT
	a.measure_id,
	a.measure_name
FROM readmissions_state a
LEFT OUTER JOIN measure_map b
ON a.measure_id = b.measure_id
AND b.measure_id IS NULL
GROUP BY a.measure_id,a.measure_name
;

INSERT INTO measure_map
SELECT
	a.measure_id,
	a.measure_name
FROM spending_hospital a
LEFT OUTER JOIN measure_map b
ON a.measure_id = b.measure_id
AND b.measure_id IS NULL
GROUP BY a.measure_id,a.measure_name
;

INSERT INTO measure_map
SELECT
	a.measure_id,
	a.measure_name
FROM spending_state a
LEFT OUTER JOIN measure_map b
ON a.measure_id = b.measure_id
AND b.measure_id IS NULL
GROUP BY a.measure_id,a.measure_name
;

INSERT INTO measure_map
SELECT
	a.measure_id,
	a.measure_name
FROM hai_hospital a
LEFT OUTER JOIN measure_map b
ON a.measure_id = b.measure_id
AND b.measure_id IS NULL
GROUP BY a.measure_id,a.measure_name
;

INSERT INTO measure_map
SELECT
	a.measure_id,
	a.measure_name
FROM hai_state a
LEFT OUTER JOIN measure_map b
ON a.measure_id = b.measure_id
AND b.measure_id IS NULL
GROUP BY a.measure_id,a.measure_name
;