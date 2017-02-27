DROP TABLE IF EXISTS top_hospitals;
CREATE TABLE top_hospitals AS
SELECT
	*
FROM best_hospitals
WHERE better_general_comparison_count > 1
AND worse_general_comparison_count < 2
AND worse_hai_measure_count = 0
AND better_hai_measure_count > 0
AND readmission_average <= 15
AND mortality_average <= 15
;