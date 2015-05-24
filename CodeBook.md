## Code Book
####
###### The script run_analysis.R performs the following 5 steps:
###### 1. Merges the training and the test sets to create one data set.
###### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
###### 3. Uses descriptive activity names to name the activities in the data set.
###### 4. Appropriately labels the data set with descriptive variable names.
###### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
####
###### First, all the data files with the same number of columns and referring to the same entities is merged using the rbind() function. 
###### Then, the mean and standard deviation columns pulled from the dataset, and they're given the names from "features.txt".
###### The activity labels from "activity_labels.txt" are substituted in the dataset.
###### The columns with vague column names are corrected throughout the whole data set.
###### A new data set ("tidy_data_w_averages.txt") is created and stored with all the averages for the subject and activity type.

## Variables
####
###### *x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
###### *temp1, temp2, X, S, and Y merge the previous datasets for further work.
###### *Features contains the correct names for the X dataset, which are applied to the column names stored in NeededFeatures (a numeric vector used to extract the desired data).
###### *Activity names are applied through the use of the activities variable.
###### *Clean merges S, Y, and X into a big dataset.
###### *Finally, result contains the relevant averages which will be later stored in the tidy_data_w_averages.txt file.
