DROP TABLE IF EXISTS readmissions_hospitals_scores_average;
CREATE TABLE readmissions_hospitals_scores_average AS
SELECT
	provider_id,
	CASE WHEN measure_id LIKE 'READM%' THEN 'readmission_average'
		WHEN measure_id LIKE 'MORT%' THEN 'mortality_average' END
		AS measure_group,
	AVG(score) AS average_score
FROM readmissions_hospitals_scores
GROUP BY
	provider_id,
	CASE WHEN measure_id LIKE 'READM%' THEN 'readmission_average'
		WHEN measure_id LIKE 'MORT%' THEN 'mortality_average' END
;

DROP TABLE IF EXISTS readmissions_hospitals_scores_pop_stats;
CREATE TABLE readmissions_hospitals_scores_pop_stats AS
SELECT
	measure_group,
	AVG(average_score) AS pop_mean_score,
	MIN(average_score) AS pop_min_score,
	MAX(average_score) AS pop_max_score,
	STDDEV_POP(average_score) AS pop_std_score
FROM readmissions_hospitals_scores_average
GROUP BY measure_group
;

DROP TABLE IF EXISTS hai_hospitals_scores_agg;
CREATE TABLE hai_hospitals_scores_agg AS
SELECT
	a.provider_id,
	COUNT(DISTINCT b.measure_id) AS worse_hai_measure_count,
	COUNT(DISTINCT c.measure_id) AS better_hai_measure_count
FROM hai_hospitals_scores a
LEFT OUTER JOIN (
	SELECT
		provider_id,
		measure_id,
		compared_to_national
	FROM hai_hospitals_scores
	WHERE measure_id LIKE '%SIR'
	AND compared_to_national LIKE 'Worse%'
) b
ON a.provider_id = b.provider_id
AND a.measure_id = b.measure_id
AND a.measure_id LIKE '%SIR'
LEFT OUTER JOIN (
	SELECT
		provider_id,
		measure_id,
		compared_to_national
	FROM hai_hospitals_scores
	WHERE measure_id LIKE '%SIR'
	AND compared_to_national LIKE 'Better%'
) c
ON a.provider_id = c.provider_id
AND a.measure_id = c.measure_id
AND a.measure_id LIKE '%SIR'
GROUP BY a.provider_id
;

DROP TABLE IF EXISTS hai_hospitals_scores_agg_pop_stats;
CREATE TABLE hai_hospitals_scores_agg_pop_stats AS
SELECT
	AVG(better_hai_measure_count) AS better_hai_pop_mean,
	AVG(worse_hai_measure_count) AS worse_hai_pop_mean,
	MAX(better_hai_measure_count) AS better_hai_pop_max,
	MAX(worse_hai_measure_count) AS worse_hai_pop_max,
	MIN(better_hai_measure_count) AS better_hai_pop_min,
	MIN(worse_hai_measure_count) AS worse_hai_pop_min,
	STDDEV_POP(better_hai_measure_count) AS better_hai_pop_std,
	STDDEV_POP(worse_hai_measure_count) AS worse_hai_pop_std
FROM hai_hospitals_scores_agg
;

DROP TABLE IF EXISTS hospitals_general_agg;
CREATE TABLE hospitals_general_agg AS
SELECT
	provider_id,
	CASE WHEN mortality_comp LIKE 'Above%' THEN 1 ELSE 0 END +
		CASE WHEN safety_care_comp LIKE 'Above%' THEN 1 ELSE 0 END +
		CASE WHEN readmission_comp LIKE 'Above%' THEN 1 ELSE 0 END +
		CASE WHEN pat_exp_comp LIKE 'Above%' THEN 1 ELSE 0 END +
		CASE WHEN effective_care_comp LIKE 'Above%' THEN 1 ELSE 0 END +
		CASE WHEN timeliness_care_comp LIKE 'Above%' THEN 1 ELSE 0 END +
		CASE WHEN efficient_imaging_comp LIKE 'Above%' THEN 1 ELSE 0 END
		AS better_general_comparison_count,
	CASE WHEN mortality_comp LIKE 'Below%' THEN 1 ELSE 0 END +
		CASE WHEN safety_care_comp LIKE 'Below%' THEN 1 ELSE 0 END +
		CASE WHEN readmission_comp LIKE 'Below%' THEN 1 ELSE 0 END +
		CASE WHEN pat_exp_comp LIKE 'Below%' THEN 1 ELSE 0 END +
		CASE WHEN effective_care_comp LIKE 'Below%' THEN 1 ELSE 0 END +
		CASE WHEN timeliness_care_comp LIKE 'Below%' THEN 1 ELSE 0 END +
		CASE WHEN efficient_imaging_comp LIKE 'Below%' THEN 1 ELSE 0 END
		AS worse_general_comparison_count
FROM hospital_general_ratings
;

DROP TABLE IF EXISTS hospitals_general_agg_pop_stats;
CREATE TABLE hospitals_general_agg_pop_stats AS
SELECT
	AVG(better_general_comparison_count) AS better_general_pop_mean,
	AVG(worse_general_comparison_count) AS worse_general_pop_mean,
	MAX(better_general_comparison_count) AS better_general_pop_max,
	MAX(worse_general_comparison_count) AS worse_general_pop_max,
	MIN(better_general_comparison_count) AS better_general_pop_min,
	MIN(worse_general_comparison_count) AS worse_general_pop_min,
	STDDEV_POP(better_general_comparison_count) AS better_general_pop_std,
	STDDEV_POP(worse_general_comparison_count) AS worse_general_pop_std
FROM hospitals_general_agg
;

DROP TABLE IF EXISTS best_hospitals;
CREATE TABLE best_hospitals AS
SELECT
	a.provider_id,
	b.hospital_name,
	a.mortality_comp,
	a.safety_care_comp,
	a.readmission_comp,
	a.pat_exp_comp,
	a.effective_care_comp,
	a.timeliness_care_comp,
	a.efficient_imaging_comp,
	c.average_score AS readmission_agg_score,
	d.average_score AS mortality_agg_score,
	e.worse_hai_measure_count,
	e.better_hai_measure_count,
	f.better_general_comparison_count,
	f.worse_general_comparison_count
FROM hospital_general_ratings a
LEFT OUTER JOIN hospital_general_info b
	ON a.provider_id = b.provider_id
LEFT OUTER JOIN readmissions_hospitals_scores_average c
	ON a.provider_id = c.provider_id
	AND c.measure_group = 'readmission_average'
LEFT OUTER JOIN readmissions_hospitals_scores_average d
	ON a.provider_id = d.provider_id
	AND d.measure_group = 'mortality_average'
LEFT OUTER JOIN hai_hospitals_scores_agg e
	ON a.provider_id = e.provider_id
LEFT OUTER JOIN hospitals_general_agg f
	ON a.provider_id = f.provider_id
;
/*
DROP TABLE IF EXISTS top_hospitals;
CREATE TABLE top_hospitals AS
SELECT
	a.provider_id,
	a.hospital_name,
	a.readmission_agg_score,
	(SELECT pop_mean_score FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'readmission_average') AS readmission_agg_pop_mean,
	(SELECT pop_max_score FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'readmission_average') AS readmission_agg_pop_max,
	(SELECT pop_min_score FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'readmission_average') AS readmission_agg_pop_min,
	(SELECT pop_std_score FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'readmission_average') AS readmission_agg_pop_std,
	a.mortality_agg_score,
	(SELECT pop_mean_score FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'mortality_average') AS mortality_agg_pop_mean,
	(SELECT pop_max_score FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'mortality_average') AS mortality_agg_pop_max,
	(SELECT pop_min_score FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'mortality_average') AS mortality_agg_pop_min,
	(SELECT pop_std_score FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'mortality_average') AS mortality_agg_pop_std,
	a.better_hai_measure_count,
	(SELECT better_hai_pop_mean FROM hai_hospitals_scores_agg_pop_stats) AS better_hai_pop_mean,
	(SELECT better_hai_pop_max FROM hai_hospitals_scores_agg_pop_stats) AS better_hai_pop_max,
	(SELECT better_hai_pop_min FROM hai_hospitals_scores_agg_pop_stats) AS better_hai_pop_min,
	a.worse_hai_measure_count,
	(SELECT worse_hai_pop_mean FROM hai_hospitals_scores_agg_pop_stats) AS worse_hai_pop_mean,
	(SELECT worse_hai_pop_max FROM hai_hospitals_scores_agg_pop_stats) AS worse_hai_pop_max,
	(SELECT worse_hai_pop_min FROM hai_hospitals_scores_agg_pop_stats) AS worse_hai_pop_min,
	a.better_general_comparison_count,
	(SELECT better_general_pop_mean FROM hospitals_general_agg_pop_stats) AS better_general_pop_mean,
	(SELECT better_general_pop_max FROM hospitals_general_agg_pop_stats) AS better_general_pop_max,
	(SELECT better_general_pop_min FROM hospitals_general_agg_pop_stats) AS better_general_pop_min,
	a.worse_general_comparison_count,
	(SELECT worse_general_pop_mean FROM hospitals_general_agg_pop_stats) AS worse_general_pop_mean,
	(SELECT worse_general_pop_max FROM hospitals_general_agg_pop_stats) AS worse_general_pop_max,
	(SELECT worse_general_pop_min FROM hospitals_general_agg_pop_stats) AS worse_general_pop_min
FROM best_hospitals a
WHERE a.better_general_comparison_count > 1
	AND a.worse_general_comparison_count = 0
	AND a.worse_hai_measure_count = 0
	AND a.better_hai_measure_count > 0
	AND a.readmission_agg_score <= 12
	AND a.mortality_agg_score <= 12
	AND a.mortality_comp NOT LIKE 'Not Available'
	AND a.safety_care_comp NOT LIKE 'Not Available'
	AND a.readmission_comp NOT LIKE 'Not Available'
	AND a.pat_exp_comp NOT LIKE 'Not Available'
	AND a.effective_care_comp NOT LIKE 'Not Available'
	AND a.timeliness_care_comp NOT LIKE 'Not Available'
	AND a.efficient_imaging_comp NOT LIKE 'Not Available'
;
*/

DROP TABLE IF EXISTS top_hospitals;
CREATE TABLE top_hospitals AS
SELECT
	a.provider_id,
	a.hospital_name,
	a.readmission_agg_score,
	a.mortality_agg_score,
	a.better_hai_measure_count,
	a.worse_hai_measure_count,
	a.better_general_comparison_count,
	a.worse_general_comparison_count
FROM best_hospitals a
WHERE a.better_general_comparison_count > 1
	AND a.worse_general_comparison_count = 0
	AND a.worse_hai_measure_count = 0
	AND a.better_hai_measure_count > 0
	AND a.readmission_agg_score <= 12
	AND a.mortality_agg_score <= 12
	AND a.mortality_comp NOT LIKE 'Not Available'
	AND a.safety_care_comp NOT LIKE 'Not Available'
	AND a.readmission_comp NOT LIKE 'Not Available'
	AND a.pat_exp_comp NOT LIKE 'Not Available'
	AND a.effective_care_comp NOT LIKE 'Not Available'
	AND a.timeliness_care_comp NOT LIKE 'Not Available'
	AND a.efficient_imaging_comp NOT LIKE 'Not Available'
;

ALTER TABLE top_hospitals ADD COLUMNS (readmission_agg_pop_mean DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (readmission_agg_pop_max DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (readmission_agg_pop_min DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (readmission_agg_pop_std DECIMAL);

UPDATE top_hospitals
SET readmission_agg_pop_mean = (SELECT pop_mean_score FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'readmission_average');

ALTER TABLE top_hospitals ADD COLUMNS (mortality_agg_pop_mean DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (mortality_agg_pop_max DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (mortality_agg_pop_min DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (mortality_agg_pop_std DECIMAL);

ALTER TABLE top_hospitals ADD COLUMNS (better_hai_pop_mean DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (better_hai_pop_max DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (better_hai_pop_min DECIMAL);

ALTER TABLE top_hospitals ADD COLUMNS (worse_hai_pop_mean DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (worse_hai_pop_max DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (worse_hai_pop_min DECIMAL);

ALTER TABLE top_hospitals ADD COLUMNS (better_general_pop_mean DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (better_general_pop_max DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (better_general_pop_min DECIMAL);

ALTER TABLE top_hospitals ADD COLUMNS (worse_general_pop_mean DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (worse_general_pop_max DECIMAL);
ALTER TABLE top_hospitals ADD COLUMNS (worse_general_pop_min DECIMAL);