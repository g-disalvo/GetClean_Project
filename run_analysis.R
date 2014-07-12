## This provides a set of functions to collect, work with, and clean a data 
## set. It is designed to work with data from the UCI Machine Learning 
## Repository Human Activity Recognition Using Smartphones Data Set.

## GD - 7/11/14 - initial release

baseDataDir <- "UCI HAR Dataset"    # global variable identifying data base path

readSet <- function(setName) {
    ## usage: readset(setName)
    ##   Reads data from setName dataset and returns a data table. Filenames 
    ##   are built up from the global variable baseName and the local 
    ##   variables here. 
    ##   NOTE: Only the existance of the feature data file is checked here.
    ##   The other files are assumed to exist. If they don't a system
    ##   error message will be generated.
    
    ## parameters:
    ##   setName    identifies the target dataset (e.g., "test", "train")
    
    ## examples:
    ## >  readSet("train")
    ## [1] "Reading train"

    # Build qualified filenames
    subjectDataFN <- sprintf("%s/%s/subject_%s.txt", baseDataDir, setName, setName)
    activityDataFN <- sprintf("%s/%s/y_%s.txt", baseDataDir, setName, setName)
    featureDataFN <- sprintf("%s/%s/x_%s.txt", baseDataDir, setName, setName)
    
    if (!(file.exists(featureDataFN))){
        print(t <- sprintf("Error reading %s: file doesn't exist", featureDataFN))
    } else {
        print(t <- sprintf("Reading %s", setName))  # let the user know something is happening
    
        result <- read.table(subjectDataFN, col.names = "Subject")  # read test subject data
        result <- cbind(result, read.table(activityDataFN, col.names = "Activity")) # add (coded) activity data
        result <- cbind(result, setName)    # add source dataset identifier
        colnames(result)[3] <- "SourceDataset"
        result <- cbind(result, read.table(featureDataFN))  # add feature data
    }
}

buildOneSet <- function() {
    ## usage: buildOneSet()
    ##   Reads the "test" and "train" datasets and returns a single data table
    ##   containing the combined data.
    
    ## parameters:
    ##   No parameters are used by this function.
    
    ## examples:
    ## >  buildOneSet()
    ## [1] "Reading train"
    ## [1] "Reading test"

    # Laminate the two datasets provided for this project
    result <- readSet("train")
    result <- rbind(result, readSet("test"))
}

subsetDS <- function(filter, dataset) {
    ## usage: subsetDS(filter, dataset)
    ##   Takes a subset of the input data based on filter. This is returned
    ##   as a new dataset.
    
    ## parameters:
    ##   filter     a regex filter string indentifying the desired fields in the source dataset
    ##   dataset    the original dataset
    
    ## examples:
    ## >  subsetDS("mean|std", t)
    ##   Subject Activity SourceDataset tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
    ##         1       1        5         train         0.2885845       -0.02029417        -0.1329051
    ##         2       1        5         train         0.2784188       -0.01641057        -0.1235202
    ##         3       1        5         train         0.2796531       -0.01946716        -0.1134617
    ##         4       1        5         train         0.2791739       -0.02620065        -0.1232826
    ##         5       1        5         train         0.2766288       -0.01656965        -0.1153619
    ##         6       1        5         train         0.2771988       -0.01009785        -0.1051373
    ##   ...

    # Read feature labels
    featureLabelFN <- sprintf("%s/features.txt", baseDataDir)
    featureLabels <- read.table(featureLabelFN, col.names = c("ID", "FeatureName"))
    
    # Identify desired fields
    m <- regexpr(filter, featureLabels$FeatureName) # filter using regular expression
    f <- sprintf("V%d", which(m > 0))    # format matching field names (m > 0) to match readSet labels
    
    # Do filtering
    result <- dataset[,c("Subject", "Activity", "SourceDataset", f)]    # pull desired fields
    names(result) <- c("Subject", "Activity", "SourceDataset", as.character(featureLabels$FeatureName[(m > 0)]))    # rename fields appropriately
    
    return(result)
}

labelActivities <- function(dataset) {
    ## usage: labelActivities(dataset)
    ##   Replaces the Activity IDs in dataset with activity labels given in 
    ##   activity_labels.txt. The modified dataset is returned.
    
    ## parameters:
    ##   dataset    the original dataset
    
    ## examples:
    ## > labelActivities(t)
    ##   Subject Activity SourceDataset tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
    ##         1       1 STANDING         train         0.2885845       -0.02029417        -0.1329051
    ##         2       1 STANDING         train         0.2784188       -0.01641057        -0.1235202
    ##         3       1 STANDING         train         0.2796531       -0.01946716        -0.1134617
    ##         4       1 STANDING         train         0.2791739       -0.02620065        -0.1232826
    ##         5       1 STANDING         train         0.2766288       -0.01656965        -0.1153619
    ##         6       1 STANDING         train         0.2771988       -0.01009785        -0.1051373
    ##   ...

    # Read activity labels
    activityLabelFN <- sprintf("%s/activity_labels.txt", baseDataDir)
    activityLabels <- read.table(activityLabelFN, col.names = c("ID", "Activity"))

    # Loop to substitute data
    for (i in activityLabels$ID) {
        dataset$Activity[(dataset$Activity == i)] = as.character(activityLabels$Activity[i])
    }
    
    return(dataset)
}

createSummarySet <- function(dataset) {
    ## usage: createSummarySet(dataset)
    ##   Creates a summary dataset by computing the means of each field for 
    ##   each activity and subject.
    
    ## parameters:
    ##   dataset    the original dataset
    
    ## examples:
    ## > createSummarySet(t)
    ##   Activity Subject tBodyAcc-mean()-X    tBodyAcc-mean()-Y   tBodyAcc-mean()-Z   tBodyAcc-std()-X
    ## 1 STANDING       1 0.278917629056604  -0.0161375901037736  -0.110601817735849 -0.995759901509434
    ## 2 STANDING       3 0.280046513278689  -0.0143376555065574  -0.101621722633148  -0.96674254295082
    ## 3 STANDING       5 0.282544390892857 -0.00700418554517857  -0.102171095696429 -0.968591815714286
    ## 4 STANDING       6 0.280346248596491  -0.0181236327175439  -0.112172831947368 -0.981758159649123
    ## 5 STANDING       7 0.282723539433962  -0.0145740341037736 -0.0997778303207547 -0.979307570377358
    ## 6 STANDING       8 0.279620986111111  -0.0148113067148148  -0.106114996837037 -0.988815418148148
    ## ...
    
    result <- dataset[0, -3]    # create result data frame using original structure (without SourceDataset field)
    for (i in unique(dataset$Activity)) {
        for (j in unique(dataset$Subject)) {
            result <- rbind(result, data.frame(Activity=i, Subject=j, as.list(colMeans(dataset[((dataset$Activity == i) & (dataset$Subject == j)), -1:-3]))))
        }
    }
    
    return(result)
}

main <- function() {
    ## usage: main()
    ##   A wrapper function that calls the others in order to address the 
    ##   Coursera Getting and Cleaning Data Project 1 problem. It writes
    ##   a file named "means_summary.txt".
    
    ## parameters:
    ##   No parameters are used by this function.
    
    ## examples:
    ## > main()
    ## [1] "Searching for data"
    ## [1] "Reading train"
    ## [1] "Reading test"
    ## [1] "Now take a subset"
    ## [1] "Label fields suitably"
    ## [1] "Create tidy summary"
    ## [1] "Writing summary file"
    ##   Activity Subject tBodyAcc-mean()-X    tBodyAcc-mean()-Y   tBodyAcc-mean()-Z   tBodyAcc-std()-X
    ## 1 STANDING       1 0.278917629056604  -0.0161375901037736  -0.110601817735849 -0.995759901509434
    ## 2 STANDING       3 0.280046513278689  -0.0143376555065574  -0.101621722633148  -0.96674254295082
    ## 3 STANDING       5 0.282544390892857 -0.00700418554517857  -0.102171095696429 -0.968591815714286
    ## 4 STANDING       6 0.280346248596491  -0.0181236327175439  -0.112172831947368 -0.981758159649123
    ## 5 STANDING       7 0.282723539433962  -0.0145740341037736 -0.0997778303207547 -0.979307570377358
    ## 6 STANDING       8 0.279620986111111  -0.0148113067148148  -0.106114996837037 -0.988815418148148
    ## ...
    
    print("Searching for data")
    t <- buildOneSet()
    
    print("Now take a subset")
    t <- subsetDS("mean|std", t)
    
    print("Label fields suitably")
    t <- labelActivities(t)
    
    print("Create tidy summary")
    result <- createSummarySet(t)
    
    print("Writing summary file")
    write.table(result, "means_summary.txt", row.names=FALSE)
}