-- creating tansformed healthcare associated infection hospital score table
DROP TABLE IF EXISTS hai_hospitals_scores;
CREATE TABLE hai_hospitals_scores AS
SELECT
	CAST(provider_id AS INT),
	measure_id,
	measure_name,
	(CASE WHEN compared_to_national = 'Not Available'
		THEN NULL ELSE compared_to_national END)
		AS compared_to_national,
	CAST((CASE WHEN score = 'Not Available'
		THEN NULL ELSE score END) AS DECIMAL)
		AS score
FROM hai_hospital
;