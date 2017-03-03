-- calculating variance of readmissions and mortality measures
DROP TABLE IF EXISTS readmissions_variance;
CREATE TABLE readmissions_variance AS
SELECT
	measure_id,
	measure_name,
	VARIANCE(score) AS score_variance,
	STDDEV_SAMP(score) AS score_std,
	STDDEV_SAMP(score)/AVG(score) AS score_coefficient_variation
FROM readmissions_hospitals_scores
GROUP BY measure_id, measure_name
;

-- calculating variance of healthcare associated infection measures
DROP TABLE IF EXISTS hai_variance;
CREATE TABLE hai_variance AS
SELECT
	measure_id,
	measure_name,
	VARIANCE(score) AS score_variance,
	STDDEV_SAMP(score) AS score_std,
	STDDEV_SAMP(score)/AVG(score) AS score_coefficient_variation
FROM hai_hospitals_scores
WHERE measure_id LIKE '%SIR'
GROUP BY measure_id, measure_name
;

-- merging variance together and joining to name map
DROP TABLE IF EXISTS merged_variance;
CREATE TABLE merged_variance AS
SELECT
	a.measure_name,
	a.score_variance,
	a.score_std,
	a.score_coefficient_variation
FROM readmissions_variance a
UNION ALL
SELECT
	b.measure_name,
	b.score_variance,
	b.score_std,
	b.score_coefficient_variation
FROM hai_variance b
;

-- selecting top 10 variance
DROP TABLE IF EXISTS top_10_variable_procedures;
CREATE TABLE top_10_variable_procedures AS
SELECT
	*
FROM merged_variance
ORDER BY score_coefficient_variation DESC
LIMIT 10
;

