# renaming files and removing headers in /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Hospital\ General\ Information.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hospitals.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Timely\ and\ Effective\ Care\ -\ Hospital.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/effective_care_hospital.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Timely\ and\ Effective\ Care\ -\ State.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/effective_care_state.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Readmissions\ and\ Deaths\ -\ Hospital.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/readmissions_hospital.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Readmissions\ and\ Deaths\ -\ State.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/readmissions_state.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Medicare\ Hospital\ Spending\ per\ Patient\ -\ Hospital.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/spending_hospital.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Medicare\ Hospital\ Spending\ per\ Patient\ -\ State.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/spending_state.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Healthcare\ Associated\ Infections\ -\ Hospital.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hai_hospital.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Healthcare\ Associated\ Infections\ -\ State.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hai_state.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Measure\ Dates.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/measures.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hvbp_hcahps_11_10_2016.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/survey_responses.csv

# creating directories and loading files into hdfs
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hospitals.csv /user/w205/hospital_compare/hospitals

hdfs dfs -mkdir /user/w205/hospital_compare/effective_care_hospital
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/effective_care_hospital.csv /user/w205/hospital_compare/effective_care_hospital

hdfs dfs -mkdir /user/w205/hospital_compare/effective_care_state
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/effective_care_state.csv /user/w205/hospital_compare/effective_care_state

hdfs dfs -mkdir /user/w205/hospital_compare/readmissions_hospital
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/readmissions_hospital.csv /user/w205/hospital_compare/readmissions_hospital

hdfs dfs -mkdir /user/w205/hospital_compare/readmissions_state
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/readmissions_state.csv /user/w205/hospital_compare/readmissions_state

hdfs dfs -mkdir /user/w205/hospital_compare/spending_hospital
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/spending_hospital.csv /user/w205/hospital_compare/spending_hospital

hdfs dfs -mkdir /user/w205/hospital_compare/spending_state
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/spending_state.csv /user/w205/hospital_compare/spending_state

hdfs dfs -mkdir /user/w205/hospital_compare/hai_hospital
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hai_hospital.csv /user/w205/hospital_compare/hai_hospital

hdfs dfs -mkdir /user/w205/hospital_compare/hai_state
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hai_state.csv /user/w205/hospital_compare/hai_state

hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/measures.csv /user/w205/hospital_compare/measures

hdfs dfs -mkdir /user/w205/hospital_compare/survey_responses
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/survey_responses.csv /user/w205/hospital_compare/survey_responses

# running hive_base_ddl sql script to create tables from hdfs raw data
hive -f /home/w205/MIDS/w205/exercise_1/loading_and_modelling/hive_base_ddl.sql