# renaming files and removing headers in /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Hospital\ General\ Information.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hospitals.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Timely\ and\ Effective\ Care\ -\ Hospital.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/effective_care.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Readmissions\ and\ Deaths\ -\ Hospital.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/readmissions.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/Measure\ Dates.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/measures.csv
tail -n +2 /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/hvbp_hcahps_11_10_2016.csv > /home/w205/MIDS/w205/exercise_1/Hospital_Revised_Flatfiles/survey_responses.csv

# loading files into Hospital_Revised_Flatfiles
