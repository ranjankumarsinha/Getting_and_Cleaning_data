library(dplyr)
setwd("/Users/ranjankumar/Documents/MyR/Getting and Cleaning Data")

# Download & Unzip the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "Dataset.zip", method = "curl")
unzip("Dataset.zip")

setwd("./UCI HAR Dataset")
activity_labels <- read.table("activity_labels.txt", quote="\"", comment.char="")
names(activity_labels) <- c("Activity","Activity Description")

# Read Test Dataset
subject_test <- read.table("./test/subject_test.txt", quote="\"", comment.char="")
names(subject_test) <- c("Subject")
X_test <- read.table("./test/X_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
Y_test <- read.table("./test/Y_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

test_sub_activity <- cbind(subject_test,Y_test)
names(test_sub_activity) <- c("Subject","Activity")
test_sub_activity <- merge(test_sub_activity,activity_labels,by ="Activity")
tidy_test <-cbind(test_sub_activity,X_test) 

# Read Training Data
subject_train <- read.table("./train/subject_train.txt", quote="\"", comment.char="")
names(subject_test) <- c("Subject")
X_train <- read.table("./train/X_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
Y_train <- read.table("./train/Y_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

train_sub_activity <- cbind(subject_train,Y_train)
names(train_sub_activity) <- c("Subject","Activity")
train_sub_activity <- merge(train_sub_activity,activity_labels,by ="Activity")
tidy_train <-cbind(train_sub_activity,X_train) 

# Merge Tidy test & Tidy Training data
tidy_data <- rbind(tidy_train,tidy_test)

# Prepare vector of "descriptive variable name"
features <- read.table("features.txt", quote="\"", comment.char="")
names(features) <- c("variable_num","variable_name")
features <- select(features,variable_name)
features <- as.character(features[,,drop = TRUE])

# Assign "Descriptive variable name to Tidy dataset" 
names(tidy_data) <-c(features)

# Get all observations having mean and sd
req_col <- grepl("mean()",colnames(tidy_data)) | grepl("sd()",colnames(tidy_data))

# Add context (first three variables) i.e. Subject,Activity & Activity Descriptions in required observations
req_col <- c(TRUE,TRUE,TRUE,req_col)

# Extract data for submission
data_for_submission <- tidy_data[,req_col]
names(data_for_submission)

# Write Data to file
write.table(data_for_submission, file = "resultset.txt", sep="\t",row.names = FALSE)

