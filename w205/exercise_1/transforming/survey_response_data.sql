-- creating tansformed survey response table
DROP TABLE IF EXISTS survey_response_data_temp;
CREATE TABLE survey_response_data_temp AS
SELECT
	CAST(provider_number AS INT) AS provider_id,
	CAST((CASE WHEN communication_with_nurses_performance_rate = 'Not Available'
		THEN NULL ELSE communication_with_nurses_performance_rate END) AS DECIMAL)
		AS communication_with_nurses_performance_rate,
	CAST(communication_with_nurses_achievement_threshold AS DECIMAL) AS communication_with_nurses_achievement_threshold,
	CAST(communication_with_nurses_benchmark AS DECIMAL) AS communication_with_nurses_benchmark,
	CAST((CASE WHEN communication_with_doctors_performance_rate = 'Not Available'
		THEN NULL ELSE communication_with_doctors_performance_rate END) AS DECIMAL)
		AS communication_with_doctors_performance_rate,
	CAST(communication_with_doctors_achievement_threshold AS DECIMAL) AS communication_with_doctors_achievement_threshold,
	CAST(communication_with_doctors_benchmark AS DECIMAL) AS communication_with_doctors_benchmark,
	CAST((CASE WHEN responsiveness_of_hospital_staff_performance_rate = 'Not Available'
		THEN NULL ELSE responsiveness_of_hospital_staff_performance_rate END) AS DECIMAL)
		AS responsiveness_of_hospital_staff_performance_rate,
	CAST(responsiveness_of_hospital_staff_achievement_threshold AS DECIMAL) AS responsiveness_of_hospital_staff_achievement_threshold,
	CAST(responsiveness_of_hospital_staff_benchmark AS DECIMAL) AS responsiveness_of_hospital_staff_benchmark,
	CAST((CASE WHEN pain_management_performance_rate = 'Not Available'
		THEN NULL ELSE pain_management_performance_rate END) AS DECIMAL)
		AS pain_management_performance_rate,
	CAST(pain_management_achievement_threshold AS DECIMAL) AS pain_management_achievement_threshold,
	CAST(pain_management_benchmark AS DECIMAL) AS pain_management_benchmark,
	CAST((CASE WHEN communication_about_medicines_performance_rate = 'Not Available'
		THEN NULL ELSE communication_about_medicines_performance_rate END) AS DECIMAL)
		AS communication_about_medicines_performance_rate,
	CAST(communication_about_medicines_achievement_threshold AS DECIMAL) AS communication_about_medicines_achievement_threshold,
	CAST(communication_about_medicines_benchmark AS DECIMAL) AS communication_about_medicines_benchmark,
	CAST((CASE WHEN cleanliness_and_quietness_of_hospital_environment_performance_rate = 'Not Available'
		THEN NULL ELSE cleanliness_and_quietness_of_hospital_environment_performance_rate END) AS DECIMAL)
		AS cleanliness_and_quietness_of_hospital_environment_performance_rate,
	CAST(cleanliness_and_quietness_of_hospital_environment_achievement_threshold AS DECIMAL) AS cleanliness_and_quietness_of_hospital_environment_achievement_threshold,
	CAST(cleanliness_and_quietness_of_hospital_environment_benchmark AS DECIMAL) AS cleanliness_and_quietness_of_hospital_environment_benchmark,
	CAST((CASE WHEN discharge_information_performance_rate = 'Not Available'
		THEN NULL ELSE discharge_information_performance_rate END) AS DECIMAL)
		AS discharge_information_performance_rate,
	CAST(discharge_information_achievement_threshold AS DECIMAL) AS discharge_information_achievement_threshold,
	CAST(discharge_information_benchmark AS DECIMAL) AS discharge_information_benchmark,
	CAST((CASE WHEN overall_rating_of_hospital_performance_rate = 'Not Available'
		THEN NULL ELSE overall_rating_of_hospital_performance_rate END) AS DECIMAL)
		AS overall_rating_of_hospital_performance_rate,
	CAST(overall_rating_of_hospital_achievement_threshold AS DECIMAL) AS overall_rating_of_hospital_achievement_threshold,
	CAST(overall_rating_of_hospital_benchmark AS DECIMAL) AS overall_rating_of_hospital_benchmark,
	CAST((CASE WHEN hcahps_base_score = 'Not Available'
		THEN NULL ELSE hcahps_base_score END) AS INT)
		AS hcahps_base_score,
	CAST((CASE WHEN hcahps_consistency_score = 'Not Available'
		THEN NULL ELSE hcahps_consistency_score END) AS INT)
		AS hcahps_consistency_score
FROM survey_responses
;

DROP TABLE IF EXISTS survey_response_data;
CREATE TABLE survey_response_data AS
SELECT 
	(hcahps_base_score + hcahps_consistency_score) AS total_performance_score,
	CASE WHEN communication_with_nurses_performance_rate >= communication_with_nurses_benchmark
		THEN 1 ELSE 0 END
		AS communication_with_nurses_benchmark_met,
	CASE WHEN communication_with_nurses_performance_rate >= communication_with_nurses_achievement_threshold
		THEN 1 ELSE 0 END
		AS communication_with_nurses_threshold_met,
	CASE WHEN communication_with_doctors_performance_rate >= communication_with_doctors_benchmark
		THEN 1 ELSE 0 END
		AS communication_with_doctors_benchmark_met,
	CASE WHEN communication_with_doctors_performance_rate >= communication_with_doctors_achievement_threshold
		THEN 1 ELSE 0 END
		AS communication_with_doctors_threshold_met,
	CASE WHEN responsiveness_of_hospital_staff_performance_rate >= responsiveness_of_hospital_staff_benchmark
		THEN 1 ELSE 0 END
		AS responsiveness_of_hospital_staff_benchmark_met,
	CASE WHEN responsiveness_of_hospital_staff_performance_rate >= responsiveness_of_hospital_staff_achievement_threshold
		THEN 1 ELSE 0 END
		AS responsiveness_of_hospital_staff_threshold_met,
	CASE WHEN pain_management_performance_rate >= pain_management_benchmark
		THEN 1 ELSE 0 END
		AS pain_management_benchmark_met,
	CASE WHEN pain_management_performance_rate >= pain_management_achievement_threshold
		THEN 1 ELSE 0 END
		AS pain_management_threshold_met,
	CASE WHEN communication_about_medicines_performance_rate >= communication_about_medicines_benchmark
		THEN 1 ELSE 0 END
		AS communication_about_medicines_benchmark_met,
	CASE WHEN communication_about_medicines_performance_rate >= communication_about_medicines_achievement_threshold
		THEN 1 ELSE 0 END
		AS communication_about_medicines_threshold_met,
	CASE WHEN cleanliness_and_quietness_of_hospital_environment_performance_rate >= cleanliness_and_quietness_of_hospital_environment_benchmark
		THEN 1 ELSE 0 END
		AS cleanliness_and_quietness_of_hospital_environment_benchmark_met,
	CASE WHEN cleanliness_and_quietness_of_hospital_environment_performance_rate >= cleanliness_and_quietness_of_hospital_environment_achievement_threshold
		THEN 1 ELSE 0 END
		AS cleanliness_and_quietness_of_hospital_environment_threshold_met,
	CASE WHEN discharge_information_performance_rate >= discharge_information_benchmark
		THEN 1 ELSE 0 END
		AS discharge_information_benchmark_met,
	CASE WHEN discharge_information_performance_rate >= discharge_information_achievement_threshold
		THEN 1 ELSE 0 END
		AS discharge_information_threshold_met,
	CASE WHEN overall_rating_of_hospital_performance_rate >= overall_rating_of_hospital_benchmark
		THEN 1 ELSE 0 END
		AS overall_rating_of_hospital_benchmark_met,
	CASE WHEN overall_rating_of_hospital_performance_rate >= overall_rating_of_hospital_achievement_threshold
		THEN 1 ELSE 0 END
		AS overall_rating_of_hospital_threshold_met,
	*
FROM survey_response_data_temp
;

DROP TABLE IF EXISTS survey_response_data_temp;

