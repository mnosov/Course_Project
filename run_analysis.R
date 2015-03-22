# Creates data set which:
#    Merges the training and the test sets to create one data set.
#    Extracts only the measurements on the mean and standard deviation for each measurement. 
#    Uses descriptive activity names to name the activities in the data set
#    Appropriately labels the data set with descriptive variable names.
#
#    From the created data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
#    Parameters:
#        dir - path to directory where "UCI HAR Dataset" folder is located
#        If "UCI HAR Dataset" is in your work directory, leave this parameter default
#
# Usage (e.g. for submission):
#    source ("run_analysis.R")
#    result<-run_analysis()
#    write.table(result, file="result.txt", row.name=FALSE)
#
# Returns created data set with the average of each variable for each activity and each subject
run_analysis <- function (dir = ".") {
    library(dplyr) #use dplyr package for 'filter', 'arrange'

    #local helper function to load table from file name
    # 'dir' and "/UCI HAR Dataset/" will be prepended to fileName
    localReadTable <- function(fileName) {
        read.table(paste(dir, "/UCI HAR Dataset/", fileName, sep=""))
    }

    #load list of features (number and name)
    features<-localReadTable("features.txt")
 
    colnames(features)<-c("Number", "Name") #set column names for features

    #get the features which have "-mean()" or "-std()" in the feature names
    filteredFeatures<-filter(features, grepl("-mean()", Name, fixed=TRUE) | grepl("-std()", Name, fixed=TRUE))

    # get the activity labels data
    activityLabels<-localReadTable("activity_labels.txt")
    colnames(activityLabels)<-c("Id", "Name")
    activityLabels<-arrange(activityLabels, Id) #arrange it by Id, if it is not (1,2,3,4,5,6)

    #Helper function to read X (and filter it), Y, subject data and aggregate this into one data set
    # X data column names will be obtained from 'features' table
    # Y column name will be "Activity"
    # Subject column name will be "Subject"
    filterSubset <- function(xFileName, yFileName, subjectFileName) {
        x<-localReadTable(xFileName) #read X data (the longest one)
        colnames(x)<-features$Name   # set column names from 'features$Name'
        filteredResult<-x[, filteredFeatures$Number] #filter X data. Leave only columns specified in 'filteredFeatures'
        rm(x) # free memory used for 'x'
        y<-localReadTable(yFileName)  # read Y data (activities)

        # Get label representing activity by number
        yLabels<-activityLabels[y[,1],2]
        filteredResult$Activity<-yLabels #add activity names as a separate row to the result
        rm(y) # free memory for 'y'
        subjects<-localReadTable(subjectFileName) #read subjects
        filteredResult$Subject<-subjects[,1]   # add "Subject" row to the result with 'subjects' info
        filteredResult #return 'filteredResult'
    }

    # Get, filter, add activity&subject for training subset
    trainSet<-filterSubset("train/X_train.txt", "train/y_train.txt", "train/subject_train.txt")

    # Get, filter, add activity&subject for test subset
    testSet<-filterSubset("test/X_test.txt", "test/y_test.txt", "test/subject_test.txt")

    # Merge training and test subsets
    sumSet<-rbind(trainSet, testSet)
    rm(trainSet)
    rm(testSet)

    #Return aggregated subset representing 'mean' for each variable. Aggregated by 'Activity' and 'Subject'
    aggregate(. ~ Activity + Subject, data=sumSet, mean)
}