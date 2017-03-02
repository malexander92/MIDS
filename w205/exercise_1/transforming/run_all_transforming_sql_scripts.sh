# running all table creation and transformation sql scripts
hive -f /home/w205/MIDS/w205/exercise_1/transforming/effective_care_hospitals_scores.sql
hive -f /home/w205/MIDS/w205/exercise_1/transforming/effective_care_state_scores.sql
hive -f /home/w205/MIDS/w205/exercise_1/transforming/hai_hospitals_scores.sql
hive -f /home/w205/MIDS/w205/exercise_1/transforming/hai_state_scores.sql
hive -f /home/w205/MIDS/w205/exercise_1/transforming/hospital_general_info.sql
hive -f /home/w205/MIDS/w205/exercise_1/transforming/hospital_general_ratings.sql
hive -f /home/w205/MIDS/w205/exercise_1/transforming/readmissions_hospitals_scores.sql
hive -f /home/w205/MIDS/w205/exercise_1/transforming/readmissions_state_scores.sql
hive -f /home/w205/MIDS/w205/exercise_1/transforming/spending_hospitals_scores.sql
hive -f /home/w205/MIDS/w205/exercise_1/transforming/spending_state_scores.sql
hive -f /home/w205/MIDS/w205/exercise_1/transforming/survey_response_data.sql