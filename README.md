----------------------------------------------------------------
This project uses:
Human Activity Recognition Using Smartphones Dataset
Version 1.0
----------------------------------------------------------------
Run below script to download and unzip the data set to your current working directory 
before running the run_analysis.R script
----------------------------------------------------------------
# GettingandCleaningData-Project
Coursera-Course-Getting and Cleaning Data, Project

# Code for getting and unzipping the dataset
## 1- create dataset directory
if(!file.exists("data")){dir.create("data")}
## 2- download the data
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "data/HARdataset.zip",method = "curl")
## 3- unzip the compressed file
unzip("data/HARdataset.zip",exdir = "data")
----------------------------------------------------------------
run_analysis.R:
This script does below functionality in order to the row dataset in order to obtain the tidy set:
1-Merges the training and the test sets to create one data set.

2-Extracts only the measurements on the mean and standard deviation for each measurement.

3-Uses descriptive activity names to name the activities in the data set

4-Appropriately labels the data set with descriptive variable names.

5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The tidy data set is will be stored in the variables:
x_tidy
y