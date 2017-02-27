-- creating tansformed hospital general ratings table
DROP TABLE IF EXISTS hospital_general_ratings;
CREATE TABLE hospital_general_ratings AS
SELECT
	CAST(provider_id AS INT) AS provider_id,
	CAST(state AS VARCHAR) AS state,
	CAST(CASE WHEN meets_ehr_criteria = 'Y'
		THEN 1 ELSE 0 END AS INT)
		AS meets_ehr_criteria,
	CAST(CASE WHEN hospital_rating = 'Not Available'
		THEN NULL ELSE hospital_rating END AS INT)
		AS hospital_rating,
	CAST(mortality_comp AS VARCHAR),
	CAST(safety_care_comp AS VARCHAR),
	CAST(readmission_comp AS VARCHAR),
	CAST(pat_exp_comp AS VARCHAR),
	CAST(effective_care_comp AS VARCHAR),
	CAST(timeliness_care_comp AS VARCHAR),
	CAST(efficient_imaging_comp AS VARCHAR)
FROM hospitals
;
