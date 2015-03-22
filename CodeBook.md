### run_analysis
The script run_analysis.R creates data set which:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 

- From the created data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Parameters
Parameters for run_analysis function:
    dir - path to directory where "UCI HAR Dataset" folder is located. If "UCI HAR Dataset" is in your work directory, leave this parameter default
Function returns created data set with the average of each variable for each activity and each subject

# Usage
    source ("run_analysis.R")
    result<-run_analysis()
    write.table(result, file="result.txt", row.name=FALSE)

### How the script works
1. Filters the feature list to get only features that we're interested in (mean and standard deviation for each measurement)
To do this, the full feature list (features.txt) is filtered to have only those which have "-mean()" or "-std()" in feature's name
This list will look like
> head(filteredFeatures, 8)
  Number                 Name
1      1    tBodyAcc-mean()-X
2      2    tBodyAcc-mean()-Y
3      3    tBodyAcc-mean()-Z
4      4     tBodyAcc-std()-X
5      5     tBodyAcc-std()-Y
6      6     tBodyAcc-std()-Z
7     41 tGravityAcc-mean()-X
8     42 tGravityAcc-mean()-Y

2. For each (train and test) data set do the following
2a) Get the X data from appropriate file (X_train.txt or X_test.txt)
2b) Set column names to appropriate feature names from features.txt 
2c) Add to result set (filteredResult) only those columns that have names from 'filteredFeatures'
2c) Get 'y' (activity) data from appropriate text file
2d) Replace the number for 'y' with proper name (from activity_labels.txt)
2e) Add to 'filteredResult' the new column 'Activity' which represents the activity
2f) Add to 'filteredResult' the new column 'Subject'  which represents the number of volunteer

3. Merge filtered training and test sets (variable sumSet)

4. Calculate and return aggregated subset representing 'mean' for each variable. Aggregated by 'Activity' and 'Subject'
This is done using 'aggregate' function
> aggregate(. ~ Activity + Subject, data=sumSet, mean)




