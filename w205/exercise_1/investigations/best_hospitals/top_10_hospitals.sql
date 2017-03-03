--Creating average scores for all readmission and mortality measures
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

--Calculating population summary statistics about aggregated readmission and mortality scores
DROP TABLE IF EXISTS readmissions_hospitals_scores_pop_stats;
CREATE TABLE readmissions_hospitals_scores_pop_stats AS
SELECT
	measure_group,
	AVG(average_score) AS pop_mean_score,
	MIN(average_score) AS pop_min_score,
	MAX(average_score) AS pop_max_score,
	STDDEV_SAMP(average_score) AS pop_std_score
FROM readmissions_hospitals_scores_average
GROUP BY measure_group
;

--Creating average scores for all HAI measures
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

--Calculating population summary statistics about aggregated HAI scores
DROP TABLE IF EXISTS hai_hospitals_scores_agg_pop_stats;
CREATE TABLE hai_hospitals_scores_agg_pop_stats AS
SELECT
	AVG(better_hai_measure_count) AS better_hai_pop_mean,
	AVG(worse_hai_measure_count) AS worse_hai_pop_mean,
	MAX(better_hai_measure_count) AS better_hai_pop_max,
	MAX(worse_hai_measure_count) AS worse_hai_pop_max,
	MIN(better_hai_measure_count) AS better_hai_pop_min,
	MIN(worse_hai_measure_count) AS worse_hai_pop_min,
	STDDEV_SAMP(better_hai_measure_count) AS better_hai_pop_std,
	STDDEV_SAMP(worse_hai_measure_count) AS worse_hai_pop_std
FROM hai_hospitals_scores_agg
;

--Aggregating scores for hospital general comparison measures
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
		AS worse_general_comparison_count,
	hospital_rating
FROM hospital_general_ratings
;

--Calculating population summary statistics about aggregated hospital general comparison measures
DROP TABLE IF EXISTS hospitals_general_agg_pop_stats;
CREATE TABLE hospitals_general_agg_pop_stats AS
SELECT
	AVG(better_general_comparison_count) AS better_general_pop_mean,
	AVG(worse_general_comparison_count) AS worse_general_pop_mean,
	AVG(hospital_rating) AS hospital_rating_pop_mean,
	MAX(better_general_comparison_count) AS better_general_pop_max,
	MAX(worse_general_comparison_count) AS worse_general_pop_max,
	MAX(hospital_rating) AS hospital_rating_pop_max,
	MIN(better_general_comparison_count) AS better_general_pop_min,
	MIN(worse_general_comparison_count) AS worse_general_pop_min,
	MIN(hospital_rating) AS hospital_rating_pop_min,
	STDDEV_SAMP(better_general_comparison_count) AS better_general_pop_std,
	STDDEV_SAMP(worse_general_comparison_count) AS worse_general_pop_std,
	STDDEV_SAMP(hospital_rating) AS hospital_rating_pop_std
FROM hospitals_general_agg
;

--Joining all of the calculated aggregated measures together
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
	f.worse_general_comparison_count,
	f.hospital_rating
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

--Joining to population summary statistics
DROP TABLE IF EXISTS top_hospitals;
CREATE TABLE top_hospitals AS
SELECT
	a.provider_id,
 	a.hospital_name,
 	a.readmission_agg_score,
 	b.pop_mean_score AS readmission_agg_pop_mean,
 	b.pop_max_score AS readmission_agg_pop_max,
 	b.pop_min_score AS readmission_agg_pop_min,
 	b.pop_std_score AS readmission_agg_pop_std,
 	a.mortality_agg_score,
 	c.pop_mean_score AS mortality_agg_pop_mean,
 	c.pop_max_score AS mortality_agg_pop_max,
 	c.pop_min_score AS mortality_agg_pop_min,
 	c.pop_std_score AS mortality_agg_pop_std,
 	a.better_hai_measure_count,
 	d.better_hai_pop_mean,
 	d.better_hai_pop_max,
 	d.better_hai_pop_min,
 	a.worse_hai_measure_count,
 	d.worse_hai_pop_mean,
 	d.worse_hai_pop_max,
 	d.worse_hai_pop_min,
 	a.better_general_comparison_count,
 	e.better_general_pop_mean,
 	e.better_general_pop_max,
 	e.better_general_pop_min,
 	a.worse_general_comparison_count,
 	e.worse_general_pop_mean,
 	e.worse_general_pop_max,
 	e.worse_general_pop_min,
 	a.hospital_rating,
 	e.hospital_rating_pop_mean,
 	e.hospital_rating_pop_max,
 	e.hospital_rating_pop_min
FROM best_hospitals a
JOIN (SELECT * FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'readmission_average') b
	ON 1 = 1
JOIN (SELECT * FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'mortality_average') c
	ON 1 = 1
JOIN hai_hospitals_scores_agg_pop_stats d
	ON 1 = 1
JOIN hospitals_general_agg_pop_stats e
	ON 1 = 1
;

--Filtering to "top 10" hospitals
DROP TABLE IF EXISTS top_10_hospitals;
CREATE TABLE top_10_hospitals AS
SELECT  
        *
FROM top_hospitals
WHERE readmission_agg_score < readmission_agg_pop_mean
AND mortality_agg_score < mortality_agg_pop_mean
AND better_hai_measure_count > better_hai_pop_mean
AND better_general_comparison_count > better_general_pop_mean
AND worse_hai_measure_count < worse_hai_pop_mean
AND worse_general_comparison_count < worse_general_pop_mean
AND hospital_rating = 5
ORDER BY mortality_agg_score ASC
LIMIT 10
;