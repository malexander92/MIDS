-- creating tansformed healthcare associated infection state score table
DROP TABLE IF EXISTS hai_state_scores;
CREATE TABLE hai_state_scores AS
SELECT
	state,
	measure_id,
	measure_name,
	CAST((CASE WHEN score = 'Not Available'
		THEN NULL ELSE score END) AS DECIMAL)
		AS score
FROM hai_state
;