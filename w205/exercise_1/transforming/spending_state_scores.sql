-- creating tansformed spending state score table
DROP TABLE IF EXISTS spending_state_scores;
CREATE TABLE spending_state_scores AS
SELECT
	state,
	measure_id,
	measure_name,
	CAST((CASE WHEN score = 'Not Available'
		THEN NULL ELSE score END) AS DECIMAL)
		AS score
FROM spending_state
;