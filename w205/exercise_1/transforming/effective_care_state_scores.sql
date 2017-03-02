-- creating tansformed effectiveness of care state score table
DROP TABLE IF EXISTS effective_care_state_scores;
CREATE TABLE effective_care_state_scores AS
SELECT
	state,
	measure_id,
	measure_name,
	CAST((CASE WHEN score = 'Not Available'
		THEN NULL ELSE score END) AS INT)
		AS score
FROM effective_care_state
;