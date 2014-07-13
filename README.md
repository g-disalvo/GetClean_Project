Introduction
============
This repository provides processing functions designed to work with data from the UCI Machine Learning Repository Human Activity Recognition Using Smartphones Data Set.  

Components include:  

    README.md           this file  
    run_analysis.R      R script for manipulating the raw data  
    means_summary.txt   processed data set which provides means of the mean and summary data associated with each activity and subject in the source data set  
    CodeBook.md         a description of the fields in *mean_summary.txt* and the functions in *run_analysis.R* 

The original data is available from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

Notes on Processing
=======================
*   In creating the combined data set, I included an additional field, *SourceDataset*, to indicate the original source. This field is discarded in creating the summary set.
*   *subsetDS* uses regex filtering to subset the composite data. This provides the most flexibility and reusability for the script that I could.
*   This assumes the source data set is located in the local "UCI HAR Dataset" subdirectory (default unzip location) as per the submission details ("The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory.") This could be adjusted by changing the *baseDataDir* variable in *run_analysis.R* as needed.
*   I've included functional descriptions here rather than in the code book. It made more sense to me to leave that to describe the data only.

Descriptions of the Functions in *run_analysis.R*
====================================================

This provides a set of functions to collect, work with, and clean a data 
set. It is designed to work with data from the UCI Machine Learning 
Repository Human Activity Recognition Using Smartphones Data Set.  
NOTE: Additional detailed comments are located in the run_analysis.R file.

*Function: readset()*

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

*Function: buildOneSet()*

    ## usage: buildOneSet()
    ##   Reads the "test" and "train" datasets and returns a single data table
    ##   containing the combined data.
    
    ## parameters:
    ##   No parameters are used by this function.
    
    ## examples:
    ## >  buildOneSet()
    ## [1] "Reading train"
    ## [1] "Reading test"

*Function: subsetDS()*

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

*Function: labelActivities()*

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

*Function: createSummarySet()*

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

*Function: main()*

    ## usage: main()
    ##   A wrapper function that calls the others in order to address the 
    ##   Coursera Getting and Cleaning Data Project 1 problem. It writes
    ##   a file named "means_summary.txt".
    ## NOTE: This assumes the source data set is located in the local "UCI HAR Dataset" subdirectory (default unzip location).
    
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
