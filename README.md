### Getting-and-Cleaning-Data

This repository contains artifacts related to Coursera Data Science Course.  
Module: Getting and Cleaning Data.

The Course Assignment is to demostrate my ability to
perform key objectives for the Getting and Cleaning Data:

* Source Data from the web using R
* Save and unzip a data file into multiple local files
* Load the data into R objects.  
* Merge similar data sets
* Add and Edit Column names in a data frame. 
* Filter Columns
* Aggregate Data
* Write the data to a file accoring to "Tidy Data Set" principles. 

### Data Set:
  The Data set linked below contains a set of files related to data collection from the accelerometers of the Samsung Galaxy S smartphone.
  The purpose of the data is to develop advanced algorithms to attract new users. 
  [Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
  

  A full description of the data is available at the site where the data was obtained:
  [Data Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
  
### Data Set ETL - Extract Transfer and Load Requirements
	1. Merges the training and the test sets to create one data set.
	2. Extract only the measurements on the mean and standard deviation for each measurement. 
	3. Use descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names. 
	5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	
### Analysis Documentation 
	1. An assignment submission to Coursera with link to this Github repository containing script for performing the analysis 
	
### Artifacts in the Repository:
 
	1. run_analysis.R  - A single R Script Meeting the coding requrierments of the assignment.
	2. CodeBook.md - Descibes the variables, the data and work done to read, transform, clean up and present the data. 
	3. README.md - This Document descibing the repository and its contents. 
	4. tidy.txt - An Output file with measurements avereged by the test wearer, and the activity that was peformed.  
                  The file may be loaded with a read command similar to:
                  tidy_file <- read.table("~/DownloadFolder/tidy.txt", header=TRUE, sep = " ")
			  
	
### Tidy Data Set Principles are based on framework by 
	Hadley Wickham
	[Tidy Data](http://vita.had.co.nz/papers/tidy-data.pdf)

