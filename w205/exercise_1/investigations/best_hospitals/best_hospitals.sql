DROP TABLE IF EXISTS readmissions_hospitals_scores_average;
CREATE TABLE readmissions_hospitals_scores_average AS
SELECT
	provider_id,
	CASE WHEN measure_id LIKE 'READM%' THEN 'readmission_average'
		WHEN measure_id LIKE 'MORT%' THEN 'mortality_average' END
		AS measure_group,
	SUM(score)/COUNT(*)	AS average_score
FROM readmissions_hospitals_scores
GROUP BY
	provider_id,
	CASE WHEN measure_id LIKE 'READM%' THEN 'readmission_average'
		WHEN measure_id LIKE 'MORT%' THEN 'mortality_average' END
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
	c.average_score AS readmission_average,
	d.average_score AS mortality_average,
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

DROP TABLE IF EXISTS top_hospitals;
CREATE TABLE top_hospitals AS
SELECT
	provider_id,
	hospital_name,
	readmission_average,
	mortality_average,
	worse_hai_measure_count,
	better_hai_measure_count,
	better_general_comparison_count,
	worse_general_comparison_count
FROM best_hospitals
WHERE better_general_comparison_count > 1
AND worse_general_comparison_count = 0
AND worse_hai_measure_count = 0
AND better_hai_measure_count > 0
AND readmission_average <= 12
AND mortality_average <= 12
AND mortality_comp NOT LIKE 'Not Available'
AND safety_care_comp NOT LIKE 'Not Available'
AND readmission_comp NOT LIKE 'Not Available'
AND pat_exp_comp NOT LIKE 'Not Available'
AND effective_care_comp NOT LIKE 'Not Available'
AND timeliness_care_comp NOT LIKE 'Not Available'
AND efficient_imaging_comp NOT LIKE 'Not Available'
;