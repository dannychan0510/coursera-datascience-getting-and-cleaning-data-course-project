##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Danny Chan

# runAnalysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.  
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################


### Step 1: Merge the training and the test sets to create one data set

# set working directory
setwd("~/Documents/GitHub/coursera-datascience-getting-and-cleaning-data-course-project")

# open libraries needed
library(data.table)
library(dplyr)
library(knitr)

# read in data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# renaming columns of both test and train data frames based on features.txt
names(X_test) <- features[, 2]
names(X_train) <- features[, 2]

# renaming columns of subject_test and subject_train to "activity
names(subject_test) <- "subject"
names(subject_train) <- "subject"

# renaming columns of Y_test and Y_train to "activity"
names(Y_test) <- "activity"
names(Y_train) <- "activity"

# combining subject, Y and X for to form full test and train data tables
test <- data.table(subject_test, Y_test, X_test)
train <- data.table(subject_train, Y_train, X_train)

# merges test and train data tables to form one data table
fulldata <- as.data.table(rbind(test, train))



### Step 2: Extract only the measurements on the mean and standard deviation

# extracts only the mean and sd for each measurement
fulldata_varnames <- names(fulldata)
extract <- grep("mean|std\\(\\)", fulldata_varnames)
fulldata.ss <- subset(fulldata, select = c(1, 2, extract))


### Step 3: Use descriptive activity names to name the activities in the data set

# merge fuldata.ss with activity labels
names(activity_labels) <- c("activity", "activity_labels")
mfulldata.ss <- merge(fulldata.ss, activity_labels, by = "activity")


### Step 4: Appropriately labels the data set with descriptive variable names.

# making variable names in mfulldata.ss more intuitive
names(mfulldata.ss)<-gsub("^t", "time", names(mfulldata.ss))
names(mfulldata.ss)<-gsub("^f", "frequency", names(mfulldata.ss))
names(mfulldata.ss)<-gsub("Acc", "Accelerometer", names(mfulldata.ss))
names(mfulldata.ss)<-gsub("Gyro", "Gyroscope", names(mfulldata.ss))
names(mfulldata.ss)<-gsub("Mag", "Magnitude", names(mfulldata.ss))
names(mfulldata.ss)<-gsub("BodyBody", "Body", names(mfulldata.ss))


## Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- as.data.table(aggregate(. ~subject + activity, mfulldata.ss, mean))

# removing additional column at the end
tidyData$activity_labels <- NULL

# re-merging activity_labels
tidyData <- merge(tidyData, activity_labels, by = "activity")

# sorting columns
tidyData <- tidyData[order(tidyData$subject, tidyData$activity, tidyData$activity_labels),]

# ordering columns
temp <- names(tidyData)
temp2 <- c("subject", "activity", "activity_labels", temp[3:81])
setcolorder(tidyData, temp2)
rm(temp)
tm(temp2)

# outputting data
write.table(tidyData, file = "tidydata.txt",row.name=FALSE)
