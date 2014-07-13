UCI Human Activity Recognition Code Book
========================================================

MeansSummary Data Set Dictionary
--------------------------------------------------------

*means_summary.txt* contains a tidy data set which summarizes selected fields of the UCI Machine Learning Repository *Human Activity Recognition Using Smartphones Data Set*. 
The original data is available from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The data has been processed using the functions from the run_analysis.R script located in this repository.

Field: *Activity*  

    ##    Description:    Activity description as given in original activity_labels.txt file  
    ##    Type:           Character  
    ##    Values:         WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING  

Field: *Subject*  

    ##    Description:    Identifies the subject performing each activity  
    ##    Type:           Numeric  
    ##    Values:         1-30  

Fields:  
*tBodyAcc.mean...X*  
*tBodyAcc.mean...Y*  
*tBodyAcc.mean...Z*  
*tBodyAcc.std...X*  
*tBodyAcc.std...Y*  
*tBodyAcc.std...Z*  
*tGravityAcc.mean...X*  
*tGravityAcc.mean...Y*  
*tGravityAcc.mean...Z*  
*tGravityAcc.std...X*  
*tGravityAcc.std...Y*  
*tGravityAcc.std...Z*  
*tBodyAccJerk.mean...X*  
*tBodyAccJerk.mean...Y*  
*tBodyAccJerk.mean...Z*  
*tBodyAccJerk.std...X*  
*tBodyAccJerk.std...Y*  
*tBodyAccJerk.std...Z*  
*tBodyGyro.mean...X*  
*tBodyGyro.mean...Y*  
*tBodyGyro.mean...Z*  
*tBodyGyro.std...X*  
*tBodyGyro.std...Y*  
*tBodyGyro.std...Z*  
*tBodyGyroJerk.mean...X*  
*tBodyGyroJerk.mean...Y*  
*tBodyGyroJerk.mean...Z*  
*tBodyGyroJerk.std...X*  
*tBodyGyroJerk.std...Y*  
*tBodyGyroJerk.std...Z*  
*tBodyAccMag.mean..*  
*tBodyAccMag.std..*  
*tGravityAccMag.mean..*  
*tGravityAccMag.std..*  
*tBodyAccJerkMag.mean..*  
*tBodyAccJerkMag.std..*  
*tBodyGyroMag.mean..*  
*tBodyGyroMag.std..*  
*tBodyGyroJerkMag.mean..*  
*tBodyGyroJerkMag.std..*  
*fBodyAcc.mean...X*  
*fBodyAcc.mean...Y*  
*fBodyAcc.mean...Z*  
*fBodyAcc.std...X*  
*fBodyAcc.std...Y*  
*fBodyAcc.std...Z*  
*fBodyAcc.meanFreq...X*  
*fBodyAcc.meanFreq...Y*  
*fBodyAcc.meanFreq...Z*  
*fBodyAccJerk.mean...X*  
*fBodyAccJerk.mean...Y*  
*fBodyAccJerk.mean...Z*  
*fBodyAccJerk.std...X*  
*fBodyAccJerk.std...Y*  
*fBodyAccJerk.std...Z*  
*fBodyAccJerk.meanFreq...X*  
*fBodyAccJerk.meanFreq...Y*  
*fBodyAccJerk.meanFreq...Z*  
*fBodyGyro.mean...X*  
*fBodyGyro.mean...Y*  
*fBodyGyro.mean...Z*  
*fBodyGyro.std...X*  
*fBodyGyro.std...Y*  
*fBodyGyro.std...Z*  
*fBodyGyro.meanFreq...X*  
*fBodyGyro.meanFreq...Y*  
*fBodyGyro.meanFreq...Z*  
*fBodyAccMag.mean..*  
*fBodyAccMag.std..*  
*fBodyAccMag.meanFreq..*  
*fBodyBodyAccJerkMag.mean..*  
*fBodyBodyAccJerkMag.std..*  
*fBodyBodyAccJerkMag.meanFreq..*  
*fBodyBodyGyroMag.mean..*  
*fBodyBodyGyroMag.std..*  
*fBodyBodyGyroMag.meanFreq..*  
*fBodyBodyGyroJerkMag.mean..*  
*fBodyBodyGyroJerkMag.std..*  
*fBodyBodyGyroJerkMag.meanFreq..*  

    ## Description:    Mean (average) of the indicated measurement feature  
    ## Type:           Numeric  
    ## Values:         Varies - determined by the activity  

Data Transformations
--------------------
*   As note above, this data is culled from the UCI Machine Learning Repository *Human Activity Recognition Using Smartphones Data Set*.
*   *means_summary.txt* provides a tidy data set in that each variable is in a single column and each observation (activity/subject pair's data) is contained in a different row.
*   The steps in creating the *mean_summary* data set are:
    1. Merge the training and the test sets to create one data set.
    2. Extract only the measurements on the mean and standard deviation for each measurement.
    3. Apply descriptive activity names to name the activities in the data set.
    4. Label the data set with descriptive variable names.
    5. Create a second, independent tidy data set with the average of each variable for each activity andeach subject.
*   Details on the functions used to affect these transformations are included in *README.md*. (It made more sense to me to include them there rather than in the code book.)
*   I've chosen to include the x-/y-/z-axis mean and standard deviation data in the output (the problem statement doesn't explicitly indicate whether these are to be included along with the -XYZ feature data). This could be changed easily by modifying the regex filter passed to the *subsetDS* function.
*   The field labels are drawn directly from the original data set. My rationale is that these would be most readily understood by those interested in working with this data and provides maximum flexbility for script reuse.
