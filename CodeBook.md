#Data transformation:
-Merging the training and the test sets to create one data set.
-Extracting only the measurements on the mean and standard deviation for each measurement.
-Using descriptive activity names to name the activities in the data set
-Appropriately labeling the data set with descriptive activity names.
-Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

#R script
File "run_analysis.R" goes through all the previous steps, to create the final_tidydata.

#final_tidydata

About variables:
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in