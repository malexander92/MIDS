--Creating ratios of hosptials better/worse readmission and mortality measures for each state
DROP TABLE IF EXISTS readmissions_states_scores_average;
CREATE TABLE readmissions_states_scores_average AS
SELECT
	state,
	CASE WHEN measure_id LIKE 'READM%' THEN 'readmission_average'
		WHEN measure_id LIKE 'MORT%' THEN 'mortality_average' END
		AS measure_group,
	SUM(number_hospitals_better)/(SUM(number_hospitals_better)+SUM(number_hospitals_worse)+SUM(number_hospitals_same)+SUM(number_hospitals_too_few))  AS better_ratio,
	SUM(number_hospitals_worse)/(SUM(number_hospitals_better)+SUM(number_hospitals_worse)+SUM(number_hospitals_same)+SUM(number_hospitals_too_few))  AS worse_ratio
FROM readmissions_state_scores
GROUP BY
	state,
	CASE WHEN measure_id LIKE 'READM%' THEN 'readmission_average'
		WHEN measure_id LIKE 'MORT%' THEN 'mortality_average' END
;

--Calculating population summary statistics about state level readmission and mortality ratios
DROP TABLE IF EXISTS readmissions_states_scores_pop_stats;
CREATE TABLE readmissions_states_scores_pop_stats AS
SELECT
	measure_group,
	AVG(better_ratio) AS pop_mean_better_ratio,
	MIN(better_ratio) AS pop_min_better_ratio,
	MAX(better_ratio) AS pop_max_better_ratio,
	AVG(worse_ratio) AS pop_mean_worse_ratio,
	MIN(worse_ratio) AS pop_min_worse_ratio,
	MAX(worse_ratio) AS pop_max_worse_ratio
FROM readmissions_states_scores_average
GROUP BY measure_group
;

--Creating ratios for hosptials above/below general comparison for each state
DROP TABLE IF EXISTS state_general_agg;
CREATE TABLE state_general_agg AS
SELECT
	state,
	AVG(hospital_rating) AS avg_hospital_rating
FROM hospital_general_ratings
GROUP BY state
;

--Calculating population summary statistics about state level general comparison ratios
DROP TABLE IF EXISTS state_general_agg_pop_stats;
CREATE TABLE state_general_agg_pop_stats AS
SELECT
	AVG(avg_hospital_rating) AS hospital_rating_pop_mean,
	MAX(avg_hospital_rating) AS hospital_rating_pop_max,
	MIN(avg_hospital_rating) AS hospital_rating_pop_min
FROM state_general_agg
;

--Joining all of the calculated state level aggregated ratios together
DROP TABLE IF EXISTS best_states;
CREATE TABLE best_states AS
SELECT
	a.state,
	a.avg_hospital_rating,
	b.better_ratio AS readmission_better_ratio,
	b.worse_ratio AS readmission_worse_ratio,
	c.better_ratio AS mortality_better_ratio,
	c.worse_ratio AS mortality_worse_ratio
FROM state_general_agg a
LEFT OUTER JOIN readmissions_states_scores_average b
	ON a.state = b.state
	AND b.measure_group = 'readmission_average'
LEFT OUTER JOIN readmissions_states_scores_average c
	ON a.state = c.state
	AND c.measure_group = 'mortality_average'
;

--Joining to the population summary statistics
DROP TABLE IF EXISTS top_states;
CREATE TABLE top_states AS
SELECT
	a.state,
 	a.avg_hospital_rating,
 	d.hospital_rating_pop_mean,
 	d.hospital_rating_pop_max,
 	d.hospital_rating_pop_min,
 	a.readmission_better_ratio,
 	b.pop_mean_better_ratio AS readmission_better_ratio_pop_mean,
 	b.pop_max_better_ratio AS readmission_better_ratio_pop_max,
 	b.pop_min_better_ratio AS readmission_better_ratio_pop_min,
 	a.readmission_worse_ratio,
 	b.pop_mean_worse_ratio AS readmission_worse_ratio_pop_mean,
 	b.pop_max_worse_ratio AS readmission_worse_ratio_pop_max,
 	b.pop_min_worse_ratio AS readmission_worse_ratio_pop_min,
 	a.mortality_better_ratio,
 	c.pop_mean_better_ratio AS mortality_better_ratio_pop_mean,
 	c.pop_max_better_ratio AS mortality_better_ratio_pop_max,
 	c.pop_min_better_ratio AS mortality_better_ratio_pop_min,
 	a.mortality_worse_ratio,
 	c.pop_mean_worse_ratio AS mortality_worse_ratio_pop_mean,
 	c.pop_max_worse_ratio AS mortality_worse_ratio_pop_max,
 	c.pop_min_worse_ratio AS mortality_worse_ratio_pop_min
FROM best_states a
JOIN (SELECT * FROM readmissions_states_scores_pop_stats WHERE measure_group = 'readmission_average') b
	ON 1 = 1
JOIN (SELECT * FROM readmissions_states_scores_pop_stats WHERE measure_group = 'mortality_average') c
	ON 1 = 1
JOIN state_general_agg_pop_stats d
	ON 1 = 1
;

--Filtering to the top 10 states
DROP TABLE IF EXISTS top_10_states;
CREATE TABLE top_10_states AS
SELECT  
        *
FROM top_states
WHERE mortality_better_ratio > mortality_better_ratio_pop_mean
ORDER BY avg_hospital_rating DESC
LIMIT 10
;