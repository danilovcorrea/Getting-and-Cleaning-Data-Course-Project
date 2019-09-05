# Code Book

The run_analysis.R script performs data acquisition and tidy it through the following steps:

## Data acquisition 

“project” directory created under the working directory
Dataset downloaded to the “project” directory and extracted under the “UCI HAR Dataset” directory

# Step 1. Merges the training and the test sets to create one data set 

### Read the "activity_labels" set
“activity_Labels” (6 obs. of 2 variables) object is created by reading activity_labels.txt. Column names are assigned through the argument col.names = c("class_label", "activity")

### Read the "features" set
“features” (561 obs. of 2 variables) object is created by reading features.txt. Column names are assigned through the argument col.names = c("id","feature_list")

### Read the training sets
“x_train” (7352 obs. of 561 variables) object is created by reading features.txt. Column names are assigned through the argument col.names = features$feature_list
“y_train” (7352 obs. of 1 variable) object is created by reading features.txt. Column names are assigned through the argument col.names = "id"
“subject_train” (7352 obs. of 1 variable) object is created by reading features.txt. Column names are assigned through the argument col.names = "subject"

### Read the testing sets
“x_test” (2947 obs. of 561 variables) object is created by reading features.txt. Column names are assigned through the argument col.names = features$feature_list
“y_test” (2947 obs. of 1 variable) object is created by reading features.txt. Column names are assigned through the argument col.names = "id"
“subject_test” (2947 obs. of 1 variable) object is created by reading features.txt. Column names are assigned through the argument col.names = "subject"

### Create one merged data set
“merged_train” (7352 obs. of 563 variables) object is created by merging y_train, subject_train, x_train using cbind() function
“merged_test” (2947 obs. of 563 variables) object is created by merging y_test, subject_test, x_test using cbind() function
“merged_all” (10299 obs. of 563 variables) object is created by merging merged_train, merged_test using rbind() function

## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement

### check if “dplyr” package is installed and load the package:
if (!"dplyr" %in% installed.packages()) {install.packages("dplyr")}
library(dplyr)

### extract mean and standard deviation for each measurement
extracted_data (10299 obs. of  88 variables) is created by subsetting merged_all, selecting only columns: subject, id and the measurements on the mean and standard deviation (std) for each measurement

## Step 3. Uses descriptive activity names to name the activities in the data set

Numbers in id column of the extracted_data object were replaced by the activity name obtained from the second column of the activity_Labels object.

## Step 4. Uses descriptive activity names to name the activities in the data set

extracted_data column’s names were renamed with descriptive activity names as follows:
•	"Acc"replaced by "Accelerometer"
•	"Gyro"replaced by "Gyroscope"
•	"BodyBody"replaced by "Body"
•	"Mag"replaced by "Magnitude"
•	"^t"replaced by "Time"
•	"^f"replaced by "Frequency"
•	"tBody"replaced by "TimeBody"
•	"-mean()"replaced by "Mean"
•	"-std()"replaced by "STD"
•	"-freq()"replaced by "Frequency"
•	"angle"replaced by "Angle"
•	"gravity"replaced by "Gravity"

## Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

extracted_data_means (180 obs. of 88 variables) is created by sumarizing extracted_data taking the means of each variable for each activity and each subject, after groupped by subject and activity.

## Export tidy_data.txt

•	extracted_data_means exported as tidy_data.txt file.
