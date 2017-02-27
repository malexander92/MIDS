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
 	e.worse_general_pop_min
 FROM best_hospitals a
 JOIN (SELECT * FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'readmission_average') b
 	ON 1 = 1
 JOIN (SELECT * FROM readmissions_hospitals_scores_pop_stats WHERE measure_group = 'mortality_average') c
 	ON 1 = 1
 JOIN hai_hospitals_scores_agg_pop_stats d
 	ON 1 = 1
 JOIN hospitals_general_agg_pop_stats e
 	ON 1 = 1
 WHERE a.better_general_comparison_count >= 1
 	AND a.worse_general_comparison_count <= 2
 	AND a.worse_hai_measure_count <= 2
 	AND a.better_hai_measure_count >= 1
 	AND a.readmission_agg_score <= 15
 	AND a.mortality_agg_score <= 15
 	AND a.mortality_comp NOT LIKE 'Not Available'
 	AND a.safety_care_comp NOT LIKE 'Not Available'
 	AND a.readmission_comp NOT LIKE 'Not Available'
 	AND a.pat_exp_comp NOT LIKE 'Not Available'
 	AND a.effective_care_comp NOT LIKE 'Not Available'
 	AND a.timeliness_care_comp NOT LIKE 'Not Available'
 	AND a.efficient_imaging_comp NOT LIKE 'Not Available'
 ;