# Getting And Cleaning Data: Course Project
## Merges the training and the test sets to create one data set.
After downloading and reading in raw datasets, i use cbind and rbind to combine the following six files.
- train/subject_train.txt
- train/X_train.txt
- train/y_train.txt
- test/subject_test.txt
- test/X_test.txt
- test/y_test.txt
I did not include a seperate column for data source (i.e., train/test), because it can be telled from subject id.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
I only keep columns with "mean()" and "std()", that results 33*2=66 colomns.
## Uses descriptive activity names to name the activities in the data set.
It can be easily done by replace activity id from file "y_train/test.txt" by labels from file "activity_labels.txt".
## Appropriately labels the data set with descriptive variable names. 
I think names like "fBodyBodyGyroJerkMag-mean()" is descriptive enough, and also quite long already, and there is not need to expand it. I just remove "-" and "()" and capitalize word "mean" and "std".
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
This can be done with function "summarise_each" from "dplyr" package.
