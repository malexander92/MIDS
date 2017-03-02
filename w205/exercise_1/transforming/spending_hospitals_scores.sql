-- creating tansformed spending hospital score table
DROP TABLE IF EXISTS spending_hospitals_scores;
CREATE TABLE spending_hospitals_scores AS
SELECT
	CAST(provider_id AS INT),
	measure_id,
	measure_name,
	CAST((CASE WHEN score = 'Not Available'
		THEN NULL ELSE score END) AS DECIMAL)
		AS score
FROM spending_hospital
;