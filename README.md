# Getting and Cleaning Data - Course Project

This repository hosts the R code and documentation files for the Getting and Cleaning Data course project.


# Dataset

[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Files

`CodeBook.md` describes all the variables and summaries calculated, along with units, and all transformations and steps that was performed to get, clean up and tidy the data.

`run_analysis.R` performs data acquisition and takes the following steps to tidy it: 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

`tidy_data.txt` is the output file of the `run_analysis.R` script, a independent tidy data set with the average of each variable for each activity and each subject.
