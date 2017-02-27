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

ALTER TABLE top_hospitals ADD COLUMN readmission_agg_pop_mean DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN readmission_agg_pop_max DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN readmission_agg_pop_min DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN readmission_agg_pop_std DECIMAL;

UPDATE top_hospitals
SET readmission_agg_pop_mean = (SELECT pop_mean_score FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'readmission_average');

ALTER TABLE top_hospitals ADD COLUMN mortality_agg_pop_mean DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN mortality_agg_pop_max DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN mortality_agg_pop_min DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN mortality_agg_pop_std DECIMAL;

ALTER TABLE top_hospitals ADD COLUMN better_hai_pop_mean DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN better_hai_pop_max DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN better_hai_pop_min DECIMAL;

ALTER TABLE top_hospitals ADD COLUMN worse_hai_pop_mean DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN worse_hai_pop_max DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN worse_hai_pop_min DECIMAL;

ALTER TABLE top_hospitals ADD COLUMN better_general_pop_mean DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN better_general_pop_max DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN better_general_pop_min DECIMAL;

ALTER TABLE top_hospitals ADD COLUMN worse_general_pop_mean DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN worse_general_pop_max DECIMAL;
ALTER TABLE top_hospitals ADD COLUMN worse_general_pop_min DECIMAL;