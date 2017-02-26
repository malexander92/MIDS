DROP TABLE IF EXISTS hospitals;
CREATE EXTERNAL TABLE hospitals (
	provider_id	INT,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code INT,
	county_name STRING,
	phone_number INT,
	hospital_yype STRING,
	hospital_ownership STRING,
	emergency_services STRING,
	meets_ehr_criteria STRING, --Meets_criteria_for_meaningful_use_of_EHRs
	hospital_rating  STRING, --Hospital_overall_rating
	hospital_rating_note  STRING, --Hospital_overall_rating_footnote
	mortality_comp STRING, --Mortality_national_comparison
	mortality_comp_note STRING, --Mortality_national_comparison_footnote
	safety_care_comp STRING, --Safety_of_care_national_comparison
	safety_care_comp_note STRING, --Safety_of_care_national_comparison_footnote
	readmission_comp STRING, --Readmission_national_comparison
	readmission_comp_note STRING, --Readmission_national_comparison_footnote
	pat_exp_comp STRING, --Patient_experience_national_comparison
	pat_exp_comp_note STRING, --Patient_experience_national_comparison_footnote
	effective_care_comp STRING, --Effectiveness_of_care_national_comparison
	effective_care_comp_note STRING, --Effectiveness_of_care_national_comparison_footnote
	timeliness_care_comp STRING, --Timeliness_of_care_national_comparison
	timeliness_care_comp_note STRING, --Timeliness_of_care_national_comparison_footnote
	efficient_imaging_comp STRING, --Efficient_use_of_medical_imaging_national_comparison
	efficient_imaging_comp_note STRING --Efficient_use_of_medical_imaging_national_comparison_footnote
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals/'
;