## Load Datasets

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activities <-read.table("./UCI HAR Dataset/activity_labels.txt")

## Bind the Activity Labels to the Experimental Data

test_data <- cbind(y_test, x_test)
train_data <- cbind(y_train, x_train)

## Combine the Test Data and Train Data into one dataset

all_data <- rbind(test_data, train_data)


## Extract the names out of the features dataset
## And Label the Data set with Descriptive Activity Names

features$V2 <- as.character(features$V2)
names(all_data) <- c("Activity", features$V2)

## Add the subject identifiers to the data set 
## so we can analyze the data based on each student
all_subjects <- rbind(subject_test, subject_train)  
all_data <- cbind(all_subjects, all_data)
names(all_data)[1] <- "Subject"

## Remove Duplicate Columns
all_data <- all_data[, unique(colnames(all_data))] 

## Use the Dplyr package to select only 
## the measurements on the mean and standard deviation

library(dplyr)
all_data_tbl <- tbl_df(all_data)
select_data_tbl <- select(all_data_tbl, Subject, Activity, contains("mean"), contains("std"))

## Remove the columns that specify frequency of the mean
select_data_tbl <- select(select_data_tbl, -contains("Freq"))

## Group by Activity and Subject
select_data_tbl <- group_by(select_data_tbl, Activity, Subject)

## Creates a second, independent tidy data set with 
## the average of each variable for each activity and each subject.
tidysummaryofdata <- summarise_each(select_data_tbl, funs(mean))

## Give the data set descriptive activity names instead of just numbers
names(activities) <-c("Activity", "ActivityName")
tidysummaryofdata <- merge(activities, tidysummaryofdata)

## Drop the Activity Number column since now we have the descriptive names
tidysummaryofdata <- select(tidysummaryofdata, -Activity)

## Write the Data to a file
write.table(tidysummaryofdata, "summaryofdata.txt", row.name=FALSE)


