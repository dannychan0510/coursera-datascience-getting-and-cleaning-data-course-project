# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# set working directory
setwd("~/Documents/GitHub/coursera-datascience-getting-and-cleaning-data-course-project")

# open libraries needed
library(data.table)

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
test <- data.frame(subject_test, Y_test, X_test)
train <- data.frame(subject_train, Y_train, X_train)

# merges test and train data tables to form one data table
fulldata <- as.data.frame(rbind(test, train))

# extracts only the mean and sd for each measurement
test <- names(fulldata)
testw <- as.logical(grepl("mean()", test) + grepl("std()", test))
fulldata.ss <- as.data.frame(fulldata[, testw])
testw <- grepl("mean()", test)
