DROP TABLE IF EXISTS top_hospitals;
CREATE TABLE top_hospitals AS
SELECT
	*
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
