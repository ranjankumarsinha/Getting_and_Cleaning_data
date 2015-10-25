# Getting and Cleaning data Course Project

## Flow of Script run_analysis.R

### 1. Download  and Unzip the file
### 2. Read Activity Label file as data frame “activity_labels”
### 3. Read Subject from test directory as data frame “subject_test” and change variable name to “Subject” 
### 4. Read Observations from test directory as data frame “X_test” 
### 5. Read “Activity of Observations” from test directory as data frame “Y_test” 
### 6. Use “Cbind” and “Merge” to create a test dataset
### 7. Repeat  step 3-6 for Training dataset
### 8. Use “Rbind” to merger training and test dataset as data frame “tidy_data”
### 9. Read “features” file and create a vector which is used to rename variables in data frame “tidy_data”
### 10. Get all variables having mean and std. Used “grep” function
### 11. Prepare final dataset as “data_for_submission” using all observation but only variables related to “Mean” & “Std Deviation”
### 12. Write data to file as “results.txt”