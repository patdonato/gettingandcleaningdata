Overview
This repo contains al the requirements stated in the John Hopkins University Getting and Cleaning Data course project hosted through Coursera. It should contain the following files:
1. READme.txt
2. run_analysis.R
3. code_book.txt
4. tidydata.txt
5. HAR.zip

Data Source
Data was obtained from accelerometers from the Samsung Galaxy S smartphone. There are 30 subjects whose different static and dynamic activities were measured. Each subject was recorded multiple different times for each of the six activities.

URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Objectives
The run_analysis.R does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Process of Cleaning Data
A. Preparation
1. Load relevant packages.
2. Download the ZIP file.

B. Creating descriptive labels
1. Load and clean activity_labels.txt to extract relevant labels to be used as activity labels later in the full dataset.
2. Extract all strings with mean (excluding mean freq) and sd from features.txt to be used to select only relevant labels from B.1.
3. Clean and standardize format of B.3 and B.4.

C. Getting the main datasets
1. Load and clean all .txt files from /test directory.
2. Load and clean all .txt files from /train directory.
3. Extract only relevant columns and rows from train and test datasets using the labels created in B.3.

D. Merging the datasets
1. Combine the train and test datasets.
2. Merge the full data with the original loaded data from activity_labels.txt to ensure that the "activity name" is used as the primary index of the dataset.

E. Creating the independent tidy data.
1. Use the final data from D.2 to group and summarise (average) each column.
2. Write E.1 as tidydata.txt.


