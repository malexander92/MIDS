-- creating tansformed readmissions and deaths hospital score table
DROP TABLE IF EXISTS readmissions_hospitals_scores;
CREATE TABLE readmissions_hospitals_scores AS
SELECT
	CAST(provider_id AS INT),
	measure_id,
	CAST((CASE WHEN score = 'Not Available'
		THEN NULL ELSE score END) AS INT)
		AS score
FROM readmissions_hospital
;

DROP TABLE IF EXISTS readmissions_hospitals_scores_average;
CREATE TABLE readmissions_hospitals_scores_average AS
SELECT
	provider_id,
	CASE WHEN measure_id LIKE 'READM%' THEN 'readmission_average'
		WHEN measure_id LIKE 'MORT%' THEN 'mortality_average' END
		AS measure_group,
	SUM(score)/COUNT(*)	AS average_score
FROM readmissions_hospitals_scores
GROUP BY
	provider_id,
	CASE WHEN measure_id LIKE 'READM%' THEN 'readmission_average'
		WHEN measure_id LIKE 'MORT%' THEN 'mortality_average' END
;