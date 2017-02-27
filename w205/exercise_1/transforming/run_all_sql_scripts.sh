# running all sql scripts
hive -f effective_care_hospitals_scores.sql
hive -f effective_care_state_scores.sql
hive -f hai_hospitals_scores.sql
hive -f hai_state_scores.sql
hive -f hospital_general_info.sql
hive -f hospital_general_ratings.sql
hive -f readmissions_hospitals_scores.sql
hive -f readmissions_state_scores.sql
hive -f spending_hospitals_scores.sql
hive -f spending_state_scores.sql
hive -f survey_response_data.sql
hive -f measure_map.sql