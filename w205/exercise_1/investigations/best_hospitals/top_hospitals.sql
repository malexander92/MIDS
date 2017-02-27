DROP TABLE IF EXISTS top_10_hospitals;
CREATE TABLE top_10_hospitals AS
SELECT  
        *
FROM top_hospitals
WHERE readmission_agg_score < readmission_agg_pop_mean
AND mortality_agg_score < mortality_agg_pop_mean
AND better_hai_measure_count = better_hai_pop_max
AND better_general_comparison_count = better_general_pop_max
AND worse_hai_measure_count < worse_hai_pop_mean
AND worse_general_comparison_count < worse_general_pop_mean
;