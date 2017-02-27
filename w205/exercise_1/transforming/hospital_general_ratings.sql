-- creating tansformed hospital general ratings table
DROP TABLE IF EXISTS hospital_general_ratings;
CREATE TABLE hospital_general_ratings AS
SELECT
	CAST(provider_id AS INT),
	state,
	CAST((CASE WHEN meets_ehr_criteria = 'Y'
		THEN 1 
		WHEN meets_ehr_criteria IS NULL THEN 0
		ELSE 0 END) AS INT)
		AS meets_ehr_criteria,
	CAST((CASE WHEN hospital_rating = 'Not Available'
		THEN NULL ELSE hospital_rating END) AS INT)
		AS hospital_rating,
	mortality_comp,
	safety_care_comp,
	readmission_comp,
	pat_exp_comp,
	effective_care_comp,
	timeliness_care_comp,
	efficient_imaging_comp
FROM hospitals
;
