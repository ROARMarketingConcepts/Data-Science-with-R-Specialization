---
title: "Read Me First"
author: "Ken Wood"
date: "7/19/2020"
output: html_document
---

### Welcome to my "Getting & Cleaning Data" Course Project Submission!

For the reviewer's reference, here are the assignment instructions:

Create one R script called run_analysis.R that does the following:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the 
average of each variable for each activity and each subject.

Here are the steps taken in my scripts for each of these requirements:

>1. Merge the training and the test sets to create one data set.
a.    Download the data files.
b.    Read in the features from "features.txt".
c.    Assign second column of "feature_list" to "feature_vector".
d.    Read in X_train and assign column labels from 'feature_vector'.
e.    Read in y_train and assign column label "Activity".
f.    Read in subject_train.txt and assign column label "Subject".
g.    Read in X_test and assign column labels from 'feature_vector'.
h.    Read in y_test and assign column label "Activity".
i.    Read in subject_test and assign column label "Subject".
j.    Combine X_train and X_test to form df.
k.    Combine y_train and y_test to "Activity" column.
l.    Combine subject_train and subject_test to "Subject" column.

>2. Extract only the measurements on the mean and standard deviation for each measurement.
a. Select columns that only contain means and standard deviations. The grep pattern is `mean\\(\\)` and `std\\(\\)`.
b. Select column names with means.
c. Select column names with standard deviations.
d. Combine the two dataframes and place the columns in alphabetical order.

>3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
a. Add activity and subject vectors to final_df.
b. Adjust typo for columns with "BodyBody" in their name.
c. Uncode the activities in the "Activities" column.

>5. From the data set in step 4, create a second, independent tidy data set with the 
average of each variable for each activity and each subject.
a. Sort final_df by Activity and Subject.
b. Calculate mean values for each of the columns
c. Clean up columns in the newly formed "means" dataframe.
d. To create 'tidy' data, place "Subject" column at beginning of dataframe.

```
