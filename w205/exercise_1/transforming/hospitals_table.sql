-- creating tansformed hospitals table
DROP TABLE IF EXISTS hospitals_table;
CREATE TABLE hospitals_table AS
SELECT
	provider_id :: INT AS provider_id,
	state :: VARCHAR,
	CASE WHEN meets_ehr_criteria = 'Y'
		THEN 1 ELSE 0 END :: INT
		AS meets_ehr_criteria,
	CASE WHEN hospital_rating = 'Not Available'
		THEN NULL ELSE hospital_rating END :: INT
		AS hospital_rating,
	CASE WHEN mortality_comp = 'Not Available'
			THEN NULL
		WHEN mortality_comp = 'Same as the National average'
			THEN 0
		WHEN mortality_comp = 'Below the National average'
			THEN -1
		WHEN mortality_comp = 'Above the National average'
			THEN 1 END :: INT
		AS mortality_comp,
	CASE WHEN safety_care_comp = 'Not Available'
			THEN NULL
		WHEN safety_care_comp = 'Same as the National average'
			THEN 0
		WHEN safety_care_comp = 'Below the National average'
			THEN -1
		WHEN safety_care_comp = 'Above the National average'
			THEN 1 END :: INT
		AS safety_care_comp,
	CASE WHEN readmission_comp = 'Not Available'
			THEN NULL
		WHEN readmission_comp = 'Same as the National average'
			THEN 0
		WHEN readmission_comp = 'Below the National average'
			THEN -1
		WHEN readmission_comp = 'Above the National average'
			THEN 1 END :: INT
		AS readmission_comp,
	CASE WHEN pat_exp_comp = 'Not Available'
			THEN NULL
		WHEN pat_exp_comp = 'Same as the National average'
			THEN 0
		WHEN pat_exp_comp = 'Below the National average'
			THEN -1
		WHEN pat_exp_comp = 'Above the National average'
			THEN 1 END :: INT
		AS pat_exp_comp,
	CASE WHEN effective_care_comp = 'Not Available'
			THEN NULL
		WHEN effective_care_comp = 'Same as the National average'
			THEN 0
		WHEN effective_care_comp = 'Below the National average'
			THEN -1
		WHEN effective_care_comp = 'Above the National average'
			THEN 1 END :: INT
		AS effective_care_comp,
	CASE WHEN timeliness_care_comp = 'Not Available'
			THEN NULL
		WHEN timeliness_care_comp = 'Same as the National average'
			THEN 0
		WHEN timeliness_care_comp = 'Below the National average'
			THEN -1
		WHEN timeliness_care_comp = 'Above the National average'
			THEN 1 END :: INT
		AS timeliness_care_comp,
	CASE WHEN efficient_imaging_comp = 'Not Available'
			THEN NULL
		WHEN efficient_imaging_comp = 'Same as the National average'
			THEN 0
		WHEN efficient_imaging_comp = 'Below the National average'
			THEN -1
		WHEN efficient_imaging_comp = 'Above the National average'
			THEN 1 END :: INT
		AS efficient_imaging_comp
FROM hospitals
;
