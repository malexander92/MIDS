-- creating tansformed readmissions and deaths state score table
DROP TABLE IF EXISTS readmissions_state_scores;
CREATE TABLE readmissions_state_scores AS
SELECT
	state,
	measure_id,
	measure_name,
	CAST((CASE WHEN number_hospitals_worse = 'Not Available'
		THEN NULL ELSE number_hospitals_worse END) AS INT)
		AS number_hospitals_worse,
	CAST((CASE WHEN number_hospitals_same = 'Not Available'
		THEN NULL ELSE number_hospitals_same END) AS INT)
		AS number_hospitals_same,
	CAST((CASE WHEN number_hospitals_better = 'Not Available'
		THEN NULL ELSE number_hospitals_better END) AS INT)
		AS number_hospitals_better,
	CAST((CASE WHEN number_hospitals_too_few = 'Not Available'
		THEN NULL ELSE number_hospitals_too_few END) AS INT)
		AS number_hospitals_too_few
FROM readmissions_state
;
