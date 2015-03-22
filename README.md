### Introduction
This Readme is written under assumption that user is already familiar with used data sets.
If not, please refer to the following links:
  - Data set description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
  - Data set: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
The script run_analysis.R creates data set which:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 

- From the created data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Parameters
Parameters for run_analysis function:
    dir - path to directory where "UCI HAR Dataset" folder is located. If "UCI HAR Dataset" is in your work directory, leave this parameter default
Function returns created data set with the average of each variable for each activity and each subject

### Usage
    source ("run_analysis.R")
    result<-run_analysis()
    write.table(result, file="result.txt", row.name=FALSE)

### Folder data requirements
"UCI HAR Dataset" folder must contain the following files to allow script work properly
# activity_labels.txt
File shall contain the list of possible activities in the format like:
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
First column MUST represent the number from 1 to N, where N is a number of rows. All numbers in this column must be distinct

# features.txt
File shall contain the ordered list of names of features. Format is like:
1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y 
....
560 angle(Y,gravityMean)
561 angle(Z,gravityMean)

# train/X_train.txt
Training set with measurements. Number of columns shall be equal to number of features in features.txt

# train/y_train.txt
Training set with activity for each measurement. Shall have 1 column and number of rows must be equal to number of rows for X_train
Data shall represent 'activity number' (see activity_labels.txt), e.g. from 1 to 6

# train/subject_train.txt
Training set for subjects. Each row identifies the subject who performed the activity for each window sample. Shall be a number (e.g. from 1 to 30)

# test/X_test.txt - test set (description is equivalent to train/X_train.txt)
# test/y_test.txt - test set (description is equivalent to train/y_train.txt)
# test/subject_test.txt - test set (description is equivalent to train/subject_train.txt)
