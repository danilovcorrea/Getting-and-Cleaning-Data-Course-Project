# Peer-graded Assignment: Getting and Cleaning Data Course Project

## download and unzip the Human Activity Recognition Using Smartphones Dataset
## Version 1.0

### create project directory
if(!file.exists("./project")){dir.create("./project")}

### download the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./project/Dataset.zip")

### unzip dataset 
unzip(zipfile="./project/Dataset.zip",exdir="./project")

## run_analysis.R script

## 1. Merges the training and the test sets to create one data set.

### Read the "activity_labels" set
activity_Labels = read.table('./project/UCI HAR Dataset/activity_labels.txt',
                             col.names = c("class_label", "activity"))

### Read the "features" set
features <- read.table('./project/UCI HAR Dataset/features.txt',
                       col.names = c("id","feature_list"))

### Read the training sets
x_train <- read.table("./project/UCI HAR Dataset/train/X_train.txt",
                      col.names = features$feature_list)
y_train <- read.table("./project/UCI HAR Dataset/train/y_train.txt",
                      col.names = "id")
subject_train <- read.table("./project/UCI HAR Dataset/train/subject_train.txt",
                            col.names = "subject")

### Read the testing sets
x_test <- read.table("./project/UCI HAR Dataset/test/X_test.txt",
                     col.names = features$feature_list)
y_test <- read.table("./project/UCI HAR Dataset/test/y_test.txt",
                     col.names = "id")
subject_test <- read.table("./project/UCI HAR Dataset/test/subject_test.txt",
                           col.names = "subject")

### Create one merged data set
merged_train <- cbind(y_train, subject_train, x_train)
merged_test <- cbind(y_test, subject_test, x_test)
merged_all <- rbind(merged_train, merged_test)

## 2. Extracts only the measurements on the mean and standard deviation for each
## measurement 

if (!"dplyr" %in% installed.packages()) {install.packages("dplyr")}
library(dplyr)
extracted_data <- merged_all %>% select(subject, id, contains("mean"),
                                        contains("std"))

## 3. Uses descriptive activity names to name the activities in the data set

extracted_data$id <- activity_Labels[extracted_data$id, 2]

## 4. Appropriately labels the data set with descriptive variable names. 

names(extracted_data)[2] <- "activity"
names(extracted_data) <- gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("BodyBody", "Body", names(extracted_data))
names(extracted_data) <- gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data) <- gsub("^t", "Time", names(extracted_data))
names(extracted_data) <- gsub("^f", "Frequency", names(extracted_data))
names(extracted_data) <- gsub("tBody", "TimeBody", names(extracted_data))
names(extracted_data) <- gsub("-mean()", "Mean", names(extracted_data),
                              ignore.case = TRUE)
names(extracted_data) <- gsub("-std()", "STD", names(extracted_data),
                              ignore.case = TRUE)
names(extracted_data) <- gsub("-freq()", "Frequency", names(extracted_data),
                              ignore.case = TRUE)
names(extracted_data) <- gsub("angle", "Angle", names(extracted_data))
names(extracted_data) <- gsub("gravity", "Gravity", names(extracted_data))

## 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

### independent tidy data with all means
extracted_data_means <- extracted_data %>%
    group_by(subject, activity) %>%
    summarise_all(list(mean = mean))

### data set as a txt file created with write.table() using row.name=FALSE
write.table(extracted_data_means, "tidy_data.txt", row.names = FALSE)
