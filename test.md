# Code Book

The run_analysis.R script performs data acquisition and tidy it through the following steps:

## Data acquisition 

“project” directory created under the working directory.
```
if(!file.exists("./project")){dir.create("./project")}
```
Dataset downloaded to the “project” directory and extracted under the “UCI HAR Dataset” directory.
```
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./project/Dataset.zip")
```

## Step 1. Merges the training and the test sets to create one data set 

### Reading the "activity_labels" set
“activity_Labels” (6 obs. of 2 variables) object is created by reading activity_labels.txt. Column names are assigned through the argument col.names = c("class_label", "activity").
```
activity_Labels = read.table('./project/UCI HAR Dataset/activity_labels.txt',col.names = c("class_label", "activity"))
```
### Reading the "features" set
“features” (561 obs. of 2 variables) object is created by reading features.txt. Column names are assigned through the argument col.names = c("id","feature_list").
```
features <- read.table('./project/UCI HAR Dataset/features.txt', col.names = c("id","feature_list"))
```
### Reading the training sets
“x_train” (7352 obs. of 561 variables) object is created by reading features.txt. Column names are assigned through the argument col.names = features$feature_list.
```
x_train <- read.table("./project/UCI HAR Dataset/train/X_train.txt", col.names = features$feature_list)
```
“y_train” (7352 obs. of 1 variable) object is created by reading features.txt. Column names are assigned through the argument col.names = "id".
```
y_train <- read.table("./project/UCI HAR Dataset/train/y_train.txt", col.names = "id")
```
“subject_train” (7352 obs. of 1 variable) object is created by reading features.txt. Column names are assigned through the argument col.names = "subject".
```
subject_train <- read.table("./project/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
```
### Reading the testing sets
“x_test” (2947 obs. of 561 variables) object is created by reading features.txt. Column names are assigned through the argument col.names = features$feature_list.
```
x_test <- read.table("./project/UCI HAR Dataset/test/X_test.txt", col.names = features$feature_list)
```
“y_test” (2947 obs. of 1 variable) object is created by reading features.txt. Column names are assigned through the argument col.names = "id".
```
y_test <- read.table("./project/UCI HAR Dataset/test/y_test.txt", col.names = "id")
```
“subject_test” (2947 obs. of 1 variable) object is created by reading features.txt. Column names are assigned through the argument col.names = "subject".
```
subject_test <- read.table("./project/UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
```
### Creating one merged data set
“merged_train” (7352 obs. of 563 variables) object is created by merging y_train, subject_train, x_train using cbind() function.
```
merged_train <- cbind(y_train, subject_train, x_train)
```
“merged_test” (2947 obs. of 563 variables) object is created by merging y_test, subject_test, x_test using cbind() function.
```
merged_test <- cbind(y_test, subject_test, x_test)
```
“merged_all” (10299 obs. of 563 variables) object is created by merging merged_train, merged_test using rbind() function.
```
merged_all <- rbind(merged_train, merged_test)
```

## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement

### Checking if “dplyr” package is installed and load the package:
```
if (!"dplyr" %in% installed.packages()) {install.packages("dplyr")}
library(dplyr)
```

### Extracting mean and standard deviation for each measurement
extracted_data (10299 obs. of  88 variables) is created by subsetting merged_all, selecting only columns: subject, id and the measurements on the mean and standard deviation (std) for each measurement.
```
extracted_data <- merged_all %>% select(subject, id, contains("mean"), contains("std"))
```

## Step 3. Uses descriptive activity names to name the activities in the data set

numbers in id column of the extracted_data object were replaced by the activity name obtained from the second column of the activity_Labels object.
```
extracted_data$id <- activity_Labels[extracted_data$id, 2]
```

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

```
names(extracted_data)[2] <- "activity"
names(extracted_data) <- gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("BodyBody", "Body", names(extracted_data))
names(extracted_data) <- gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data) <- gsub("^t", "Time", names(extracted_data))
names(extracted_data) <- gsub("^f", "Frequency", names(extracted_data))
names(extracted_data) <- gsub("tBody", "TimeBody", names(extracted_data))
names(extracted_data) <- gsub("-mean()", "Mean", names(extracted_data), ignore.case = TRUE)
names(extracted_data) <- gsub("-std()", "STD", names(extracted_data), ignore.case = TRUE)
names(extracted_data) <- gsub("-freq()", "Frequency", names(extracted_data), ignore.case = TRUE)
names(extracted_data) <- gsub("angle", "Angle", names(extracted_data))
names(extracted_data) <- gsub("gravity", "Gravity", names(extracted_data))
```

## Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

extracted_data_means (180 obs. of 88 variables) is created by sumarizing extracted_data taking the means of each variable for each activity and each subject, after groupped by subject and activity.
```
extracted_data_means <- extracted_data %>%
    group_by(subject, activity) %>%
    summarise_all(list(mean = mean))
```
## Exporting tidy_data.txt

extracted_data_means exported as tidy_data.txt file.
```
write.table(extracted_data_means, "tidy_data.txt", row.names = FALSE)
```
