-- creating mapping of measure ids to names
DROP TABLE IF EXISTS measure_map;
CREATE TABLE measure_map AS
SELECT
	measure_id,
	measure_name
FROM measures
GROUP BY measure_id,measure_name
;