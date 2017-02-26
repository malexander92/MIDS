-- creating hospitals table
DROP TABLE IF EXISTS hospitals;
CREATE EXTERNAL TABLE hospitals (
	provider_id	STRING,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code STRING,
	county_name STRING,
	phone_number STRING,
	hospital_type STRING,
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

-- creating effective_care_hospital table
DROP TABLE IF EXISTS effective_care_hospital;
CREATE EXTERNAL TABLE effective_care_hospital (
	provider_id	STRING,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code STRING,
	county_name STRING,
	phone_number STRING,
	condition STRING,
	measure_id STRING,
	measure_name STRING,
	score STRING,
	sample STRING,
	footnote STRING,
	measure_start_date STRING,
	measure_end_date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care_hospital/'
;

-- creating effective_care_state table
DROP TABLE IF EXISTS effective_care_state;
CREATE EXTERNAL TABLE effective_care_state (
	state STRING,
	condition STRING,
	measure_name STRING,
	measure_id STRING,
	score STRING,
	footnote STRING,
	measure_start_date STRING,
	measure_end_date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care_state/'
;

-- creating readmissions_hospital table
DROP TABLE IF EXISTS readmissions_hospital;
CREATE EXTERNAL TABLE readmissions_hospital (
	provider_id	STRING,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code STRING,
	county_name STRING,
	phone_number STRING,
	measure_name STRING,
	measure_id STRING,
	compared_to_national  STRING,
	denominator STRING,
	score STRING,
	lower_estimate STRING,
	higher_estimate_footnote STRING,
	measure_start_date STRING,
	measure_end_date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions_hospital/'
;

-- creating readmissions_state table
DROP TABLE IF EXISTS readmissions_state;
CREATE EXTERNAL TABLE readmissions_state (
	state STRING,
	measure_name STRING,
	measure_id STRING,
	number_hospitals_worse STRING,
	number_hospitals_same STRING,
	number_hospitals_better STRING,
	number_hospitals_too_few STRING,
	footnote STRING,
	measure_start_date STRING,
	measure_end_date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions_state/'
;

-- creating spending_hospital table
DROP TABLE IF EXISTS spending_hospital;
CREATE EXTERNAL TABLE spending_hospital (
	provider_id	STRING,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code STRING,
	county_name STRING,
	phone_number STRING,
	measure_name STRING,
	measure_id STRING,
	score STRING,
	footnote STRING,
	measure_start_date STRING,
	measure_end_date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/spending_hospital/'
;

-- creating spending_state table
DROP TABLE IF EXISTS spending_state;
CREATE EXTERNAL TABLE spending_state (
	state STRING,
	measure_name STRING,
	measure_id STRING,
	score STRING,
	footnote STRING,
	measure_start_date STRING,
	measure_end_date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/spending_state/'
;

-- creating hai_hospital table
DROP TABLE IF EXISTS hai_hospital;
CREATE EXTERNAL TABLE hai_hospital (
	provider_id	STRING,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code STRING,
	county_name STRING,
	phone_number STRING,
	measure_name STRING,
	measure_id STRING,
	compared_to_national STRING,
	score STRING,
	footnote STRING,
	measure_start_date STRING,
	measure_end_date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hai_hospital/'
;

-- creating hai_state table
DROP TABLE IF EXISTS hai_state;
CREATE EXTERNAL TABLE hai_state (
	state STRING,
	measure_name STRING,
	measure_id STRING,
	score STRING,
	footnote STRING,
	measure_start_date STRING,
	measure_end_date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hai_state/'
;

-- creating measures table
DROP TABLE IF EXISTS measures;
CREATE EXTERNAL TABLE measures (
	measure_name STRING,
	measure_id STRING,
	measure_start_quarter STRING,
	measure_start_date STRING,
	measure_end_quarter STRING,
	measure_end_date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures/'
;

-- creating survey_responses table
DROP TABLE IF EXISTS survey_responses;
CREATE EXTERNAL TABLE survey_responses (
	provider_number	STRING,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code STRING,
	county_name STRING,
	communication_with_nurses_floor STRING,
	communication_with_nurses_achievement_threshold STRING,
	communication_with_nurses_benchmark STRING,
	communication_with_nurses_baseline_rate STRING,
	communication_with_nurses_performance_rate STRING,
	communication_with_nurses_achievement_points STRING,
	communication_with_nurses_improvement_points STRING,
	communication_with_nurses_dimension_score STRING,
	communication_with_doctors_floor STRING,
	communication_with_doctors_achievement_threshold STRING,
	communication_with_doctors_benchmark STRING,
	communication_with_doctors_baseline_rate STRING,
	communication_with_doctors_performance_rate STRING,
	communication_with_doctors_achievement_points STRING,
	communication_with_doctors_improvement_points STRING,
	communication_with_doctors_dimension_score STRING,
	responsiveness_of_hospital_staff_floor STRING,
	responsiveness_of_hospital_staff_achievement_threshold STRING,
	responsiveness_of_hospital_staff_benchmark STRING,
	responsiveness_of_hospital_staff_baseline_rate STRING,
	responsiveness_of_hospital_staff_performance_rate STRING,
	responsiveness_of_hospital_staff_achievement_points STRING,
	responsiveness_of_hospital_staff_improvement_points STRING,
	responsiveness_of_hospital_staff_dimension_score STRING,
	pain_management_floor STRING,
	pain_management_achievement_threshold STRING,
	pain_management_benchmark STRING,
	pain_management_baseline_rate STRING,
	pain_management_performance_rate STRING,
	pain_management_achievement_points STRING,
	pain_management_improvement_points STRING,
	pain_management_dimension_score STRING,
	communication_about_medicines_floor STRING,
	communication_about_medicines_achievement_threshold STRING,
	communication_about_medicines_benchmark STRING,
	communication_about_medicines_baseline_rate STRING,
	communication_about_medicines_performance_rate STRING,
	communication_about_medicines_achievement_points STRING,
	communication_about_medicines_improvement_points STRING,
	communication_about_medicines_dimension_score STRING,
	cleanliness_and_quietness_of_hospital_environment_floor STRING,
	cleanliness_and_quietness_of_hospital_environment_achievement_threshold STRING,
	cleanliness_and_quietness_of_hospital_environment_benchmark STRING,
	cleanliness_and_quietness_of_hospital_environment_baseline_rate STRING,
	cleanliness_and_quietness_of_hospital_environment_performance_rate STRING,
	cleanliness_and_quietness_of_hospital_environment_achievement_points STRING,
	cleanliness_and_quietness_of_hospital_environment_improvement_points STRING,
	cleanliness_and_quietness_of_hospital_environment_dimension_score STRING,	
	discharge_information_floor STRING,
	discharge_information_achievement_threshold STRING,
	discharge_information_benchmark STRING,
	discharge_information_baseline_rate STRING,
	discharge_information_performance_rate STRING,
	discharge_information_achievement_points STRING,
	discharge_information_improvement_points STRING,
	discharge_information_dimension_score STRING,
	overall_rating_of_hospital_floor STRING,
	overall_rating_of_hospital_achievement_threshold STRING,
	overall_rating_of_hospital_benchmark STRING,
	overall_rating_of_hospital_baseline_rate STRING,
	overall_rating_of_hospital_performance_rate STRING,
	overall_rating_of_hospital_achievement_points STRING,
	overall_rating_of_hospital_improvement_points STRING,
	overall_rating_of_hospital_dimension_score STRING,
	hcahps_base_score STRING,
	hcahps_consistency_score STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey_responses/'
;