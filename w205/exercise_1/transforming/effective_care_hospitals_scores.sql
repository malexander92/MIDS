-- creating tansformed effectiveness of care hospital score table
DROP TABLE IF EXISTS effective_care_hospitals_scores;
CREATE TABLE effective_care_hospitals_scores AS
SELECT
	CAST(provider_id AS INT),
	measure_id,
	measure_name,
	condition,
	CAST((CASE WHEN score = 'Not Available'
		THEN NULL ELSE score END) AS INT)
		AS score
FROM effective_care_hospital
WHERE measure_id != 'EDV'
;