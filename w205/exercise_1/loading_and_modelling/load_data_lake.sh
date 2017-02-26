# renaming files and removing headers in /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles
#tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Hospital\ General\ Information.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hospitals.csv
#tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Timely\ and\ Effective\ Care\ -\ Hospital.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/effective_care.csv
#tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Readmissions\ and\ Deaths\ -\ Hospital.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/readmissions.csv
#tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Measure\ Dates.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/measures.csv
#tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hvbp_hcahps_11_10_2016.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/survey_responses.csv

# creating directories and loading files into hdfs
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hospitals.csv /user/w205/hospital_compare/hospitals

hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/effective_care.csv /user/w205/hospital_compare/effective_care

hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/readmissions.csv /user/w205/hospital_compare/readmissions

hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/measures.csv /user/w205/hospital_compare/measures

hdfs dfs -mkdir /user/w205/hospital_compare/survey_responses
hdfs dfs -put /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/survey_responses.csv /user/w205/hospital_compare/survey_responses