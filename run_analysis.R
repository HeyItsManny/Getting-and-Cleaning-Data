# Requirements
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Description of the data set
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Data set location
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


# Prerequisites

# > .Platform$OS.type
# [1] "windows"

# > R.version
#               _                           
# platform       x86_64-w64-mingw32          
# arch           x86_64                      
# os             mingw32                     
# system         x86_64, mingw32             
# status                                     
# major          3                           
# minor          4.1                         
# year           2017                        
# month          06                          
# day            30                          
# svn rev        72865                       
# language       R                           
# version.string R version 3.4.1 (2017-06-30)
# nickname       Single Candle    


# # Set the Working Directory
setwd("~/DataScience")

# download a zip file containing broadband data. Set the target file name and save it to the working directory.
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="wearable_experiment.zip")

# unzip the destination file in the working directory
unzip("wearable_experiment.zip")

# A visual observation of the unzip shows a directory "UCI HAR Dataset" is created.
# Sub directories are test and train
# Further details on the data set are in the README.txt file in the UCI HAR Dataset directory.

# The first requirement is to merge the data sets
# to do this we first read each file from each set using read.table

# first we will do the test data set
stest <- read.table("~/DataScience/UCI HAR Dataset/test/subject_test.txt", header=FALSE)
xtest <- read.table("~/DataScience/UCI HAR Dataset/test/X_test.txt", header=FALSE)
ytest <- read.table("~/DataScience/UCI HAR Dataset/test/Y_test.txt", header=FALSE)

# Per the readme 
# The descriptions are the same for both test and train
# same loads for the train data set
strain <- read.table("~/DataScience/UCI HAR Dataset/train/subject_train.txt", header=FALSE)
xtrain <- read.table("~/DataScience/UCI HAR Dataset/train/X_train.txt", header=FALSE)
ytrain <- read.table("~/DataScience/UCI HAR Dataset/train/Y_train.txt", header=FALSE)

# we need to do a little more work to get the column names for xtest and xtrain
# read the features table so we can name columns in xtest and xtrain
features <- read.table("~/DataScience/UCI HAR Dataset/features.txt", header=FALSE)
# name the features columns
colnames(features) <- c("featureid", "featurename")


# Requirement 1 
# We will merge in two parts. First merge the rows using rbind
sdata <- rbind(stest, strain)
xdata <- rbind(xtest, xtrain)
ydata <- rbind(ytest, ytrain)


# Add column names for each set
# sdata contains the subject identification who performed the activity
colnames(sdata) <- "subjectid"

# ydata contains the labels
colnames(ydata) <- "labelid"


# xdata contains the features. We want to apply the featurename
colnames(xdata) <- features$featurename

# Requirement 2
# Filter the features data by column names.
# We only want values for columns matching the pattern std or mean
xdatastdmean <- xdata[c(grep("(mean|std)", names(xdata), value = TRUE))]

# Requirement 1 part 2 (We have already merged the rows. now bind all the columns)
df <- cbind(sdata, ydata, xdatastdmean)
# we now have one data frame with rmsubleject id, labels and only std and mean features.


#Requirement 3. Give the activity labels a descriptive activity name
activitynames <- read.table("~/DataScience/UCI HAR Dataset/activity_labels.txt", header=FALSE)
# we can observe that two variables are loaded. An id and a name. name is the 2nd var. 

# we can assign the activity names using the id for the label and the value of the activtiy name
df$labelid <- activitynames[df$labelid, 2]

#Requirement 4. Appropriately labels the data set with descriptive variable names.
# We have a few to change so we can use the pipeline function from dplyr package
library(dplyr)
dfnames <- df %>%
  setNames(gsub("subjectid", "SubjectId", names(.))) %>% 
  setNames(gsub("labelid", "ActivityName", names(.))) %>% 
  setNames(gsub("[^[:alnum:]]", "", names(.))) %>% 
  setNames(gsub("^t", "Time", names(.))) %>% 
  setNames(gsub("^f", "Frequency", names(.))) %>% 
  setNames(gsub("Acc", "Acceleration", names(.))) %>% 
  setNames(gsub("Mag", "Magnitude", names(.))) %>% 
  setNames(gsub("mean", "Mean", names(.))) %>% 
  setNames(gsub("std", "Std", names(.))) %>% 
  setNames(gsub("BodyBody", "Body", names(.))) %>% 
  setNames(gsub("Freq$", "", names(.)))

# Requirement 5. From the data set in step 4, 
# creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
dfmean <- aggregate(. ~SubjectId + ActivityName, dfnames, mean)

# My preference is to leave the data in this format to produce tidy output. 
# Each feature is in its own column. 
# An alternate solution is to reshape the features as row variables. 
# This would produce a thin output but not needed for this use case. 

# export the data
write.table(dfmean, file="tidy.txt", quote = FALSE, sep = " ", row.names=FALSE)
