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
	d.average_score AS mortality_average
FROM hospital_general_ratings a
LEFT OUTER JOIN hospital_general_info b
	ON a.provider_id = b.provider_id
LEFT OUTER JOIN readmissions_hospitals_scores_average c
	ON a.provider_id = c.provider_id
	AND c.measure_group = 'readmission_average'
LEFT OUTER JOIN readmissions_hospitals_scores_average d
	ON a.provider_id = d.provider_id
	AND d.measure_group = 'mortality_average'
;



