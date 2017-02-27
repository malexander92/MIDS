-- creating tansformed hospital general ratings table
DROP TABLE IF EXISTS hospital_general_ratings;
CREATE TABLE hospital_general_ratings AS
SELECT
	provider_id INT,
	state VARCHAR,
	CASE WHEN meets_ehr_criteria = 'Y'
		THEN 1 
		WHEN meets_ehr_criteria IS NULL THEN 0
		ELSE 0 END
		AS meets_ehr_criteria INT,
	CASE WHEN hospital_rating = 'Not Available'
		THEN NULL ELSE hospital_rating END
		AS hospital_rating INT,
	mortality_comp VARCHAR,
	safety_care_comp VARCHAR,
	readmission_comp VARCHAR,
	pat_exp_comp VARCHAR,
	effective_care_comp VARCHAR,
	timeliness_care_comp VARCHAR,
	efficient_imaging_comp VARCHAR
FROM hospitals
;
