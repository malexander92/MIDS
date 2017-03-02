-- calculating variance of readmissions and mortality measures
DROP TABLE IF EXISTS readmissions_variance;
CREATE TABLE readmissions_variance AS
SELECT
	measure_id,
	VARIANCE(score) AS score_variance,
	STDDEV_POP(score) AS score_std,
	STDDEV_POP(score)/AVG(score) AS score_coefficient_variation
FROM readmissions_hospitals_scores
GROUP BY measure_id
;

-- calculating variance of healthcare associated infection measures
DROP TABLE IF EXISTS hai_variance;
CREATE TABLE hai_variance AS
SELECT
	measure_id,
	VARIANCE(score) AS score_variance,
	STDDEV_POP(score) AS score_std,
	STDDEV_POP(score)/AVG(score) AS score_coefficient_variation
FROM hai_hospitals_scores
WHERE measure_id LIKE '%SIR'
GROUP BY measure_id
;

-- merging variance together and joining to name map
DROP TABLE IF EXISTS merged_variance;
CREATE TABLE merged_variance AS
SELECT
	b.measure_name,
	a.score_variance,
	a.score_std,
	a.score_coefficient_variation
FROM readmissions_variance a
JOIN measure_map b
	ON a.measure_id = b.measure_id
UNION ALL
SELECT
	d.measure_name,
	c.score_variance,
	c.score_std,
	c.score_coefficient_variation
FROM hai_variance c
JOIN measure_map d
	ON c.measure_id = d.measure_id
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

