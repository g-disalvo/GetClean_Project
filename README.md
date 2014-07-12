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
*   *means_summary.txt* provides a tidy data set in that each variable is in a single column and each observation (activity/subject pair's data) is contained in a different row.
*   In creating the combined data set, I included an additional field, *SourceDataset*, to indicate the original source. This field is discarded in creating the summary set.
*   *subsetDS* uses regex filtering to subset the composite data. This provides the most flexibility and reusability for the script that I could.
*   I've chosen to include the x-/y-/z-axis mean and standard deviation data in the output (the problem statement doesn't explicitly indicate whether these are to be included along with the -XYZ feature data). This could be changed easily by modifying the regex filter passed to the *subsetDS* function.
*   The field labels are drawn directly from the original data set. My rationale is that these would be most readily understood by those interested in working with this data and provides maximum flexbility for script reuse.
*   This assumes the source data set is located in the local "UCI HAR Dataset" subdirectory (default unzip location) as per the submission details ("The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory.")
*   Details on the functions are included in *CodeBook.md* as per the project description ("3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md") rather than here.
