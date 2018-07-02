## Load packages
library(data.table)
library(dplyr)
library(stringr)

## Download the ZIP file
setwd("C:/Users/HP/Desktop/JHU Getting and Cleaning Data/Week 4/Course Project")

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, dest ="HAR.zip", method="curl")
unzip(zipfile = "HAR.zip")


## Load and clean labels and features into R
setwd("C:/Users/HP/Desktop/JHU Getting and Cleaning Data/Week 4/Course Project/UCI HAR Dataset")

activity_data <- read.table("activity_labels.txt", sep = '',  col.names = c("activity_ID","activity_name"),stringsAsFactors= FALSE)
activity_data$activity_name <- tolower(activity_data$activity_name)
activity_data$activity_name <- str_replace_all(activity_data$activity_name, '_', ' ')

features_data <- read.table("features.txt",sep = '', stringsAsFactors = FALSE)


## Extract mean and sd only
with_mean <- str_which(features_data$V2, '.*mean[^Freq]')
with_sd <- str_which(features_data$V2, '.*std.*')


## Make column names to be used later
feature_data$V2 <- str_replace_all(feature_data$V2, 'Mean', 'mean')
feature_data$V2 <- str_replace_all(feature_data$V2, 'Stdev', 'sd')
feature_data$V2 <- str_replace_all(feature_data$V2, 'BodyBody', 'body')
feature_data$V2 <- str_replace_all(feature_data$V2, '\\(\\)', '')
feature_data$V2 <- str_replace_all(feature_data$V2, '-', '_')

feature_names <- filter(feature_data, V1 %in% c(with_mean, with_sd))


## Load and clean test into R
setwd("C:/Users/HP/Desktop/JHU Getting and Cleaning Data/Week 4/Course Project/UCI HAR Dataset/test")

test_data <- read.table("subject_test.txt", sep = "", col.names = c("subject_ID"))
test_y <- read.table("y_test.txt", sep = "", col.names = c("activity_ID"))
test_x <- read.table("X_test.txt", sep = "")
colnames(test_x) <- feature_data$V2

test_final <- cbind(test_data, test_y, test_x[,feature_names$V2])
 

## Load and clean train into R
setwd("C:/Users/HP/Desktop/JHU Getting and Cleaning Data/Week 4/Course Project/UCI HAR Dataset/train")

train_data <- read.table("subject_train.txt", sep = "", col.names = c("subject_ID"))
train_y <- read.table("y_train.txt", sep = "", col.names = c("activity_ID"))
train_x <- read.table("X_train.txt", sep = "")
colnames(train_x) <- feature_data$V2

train_final <- cbind(train_data, train_y, train_x[,feature_names$V2])

## Combine the training and testing data
full_data <- rbind(train_final, test_final)
final_data <- merge(full_data, activity_data, by = "activity_ID") # assures that activity will be the main index

## Create the independent tidy dataset that shows the mean of each numeric variable by activity and ID
setwd("C:/Users/HP/Desktop/JHU Getting and Cleaning Data/Week 4/Course Project")

final_data %>%
    melt(id = c("activity_name", "subject_ID")) %>%
    group_by(activity_name, subject_ID) %>%
    summarise(avg = mean(value, na.rm = TRUE)) %>%
    write.table(file = "tidydata.txt", row.names = FALSE)
