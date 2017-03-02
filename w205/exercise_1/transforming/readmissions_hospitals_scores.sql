-- creating tansformed readmissions and deaths hospital score table
DROP TABLE IF EXISTS readmissions_hospitals_scores;
CREATE TABLE readmissions_hospitals_scores AS
SELECT
	CAST(provider_id AS INT),
	measure_id,
	measure_name,
	CAST((CASE WHEN score = 'Not Available'
		THEN NULL ELSE score END) AS INT)
		AS score
FROM readmissions_hospital
;