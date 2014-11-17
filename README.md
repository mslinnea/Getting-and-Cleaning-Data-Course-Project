Getting-and-Cleaning-Data-Course-Project
========================================

## About the run_analysis.R script

### Requirements
This script requires the dplyr package.  

It also requires that you have already downloaded the data and unzipped it.
The data should be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

It should be unzipped so that the data is in a directory entitled "UCI HAR Dataset" which is in your working directory.

### Notes

Datasets are loaded and combined so that all of the test and train data is in one dataframe.  Also, the labels for each activity and the student identifiers are merged with this data set so that we can analyze the data based on student and activity.

To make summarizing the data easier, the data frame is convered to a local data frame using the dplyr package. Then the data is summarized into a tidy data set. 
