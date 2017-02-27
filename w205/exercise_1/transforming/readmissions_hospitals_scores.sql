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
	CASE WHEN measure_id ILIKE 'READM%' THEN 'readmission_average'
		WHEN measure_id ILIKE 'MORT%' THEN 'mortality_average' END
		AS measure_group,
	SUM(score)/COUNT(*)	
FROM readmissions_hospital
;