-- calculating variance of readmissions and mortality measures
DROP TABLE IF EXISTS readmissions_variance;
CREATE TABLE readmissions_variance AS
SELECT
	measure_id,
	VARIANCE(score) AS score_variance
FROM readmissions_hospitals_scores
GROUP BY measure_id
;

-- calculating variance of healthcare associated infection measures
DROP TABLE IF EXISTS hai_variance;
CREATE TABLE hai_variance AS
SELECT
	measure_id,
	VARIANCE(score) AS score_variance
FROM hai_hospitals_scores
WHERE measure_id LIKE '%SIR'
GROUP BY measure_id
;