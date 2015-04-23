## Download raw dataset
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "UCI HAR Dataset.zip", method="curl")
unzip("UCI HAR Dataset.zip")

## Read train dataset
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", colClasses="numeric")
X_train = read.table("UCI HAR Dataset/train/X_train.txt", colClasses="numeric")
y_train = read.table("UCI HAR Dataset/train/y_train.txt", colClasses="character")

## Read test dataset
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", colClasses="numeric")
X_test = read.table("UCI HAR Dataset/test/X_test.txt", colClasses="numeric")
y_test = read.table("UCI HAR Dataset/test/y_test.txt", colClasses="character")

## Read features
features = read.table("UCI HAR Dataset/features.txt", colClasses="character")

## Merge train and test dataset
dataset_train = cbind(subject_train, X_train, y_train)
dataset_test = cbind(subject_test, X_test, y_test)
dataset = rbind(dataset_train, dataset_test)
names(dataset) = c("subjectID", features[,2], "activity")

## Remove columns not mean or std
mean_features = features[,2][grep("mean\\(\\)", features[,2])]
std_features = features[,2][grep("std\\(\\)", features[,2])]
dataset = dataset[, c("subjectID", mean_features, std_features, "activity", recursive=TRUE)]

## Replace activity id with names
activities = read.table("UCI HAR Dataset/activity_labels.txt", colClasses="character")
dataset$activity = activities[,2][as.numeric(dataset$activity)]

## Format column names
names(dataset) = gsub("std\\(\\)", "Std" ,
                 gsub("mean\\(\\)", "Mean",
                 gsub("-", "", names(dataset))))

## Generating final tidy dataset
library(dplyr)
averages = summarise_each(group_by(dataset, subjectID, activity), funs(mean))
write.table(averages, "averages.txt", row.names=FALSE)
