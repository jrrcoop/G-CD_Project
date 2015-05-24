# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

# 1. Merges the training and the test sets to create one data set.

temp1 <- read.table("train/X_train.txt")
temp2 <- read.table("test/X_test.txt")
X <- rbind(temp1, temp2)

temp1 <- read.table("train/subject_train.txt")
temp2 <- read.table("test/subject_test.txt")
S <- rbind(temp1, temp2)

temp1 <- read.table("train/y_train.txt")
temp2 <- read.table("test/y_test.txt")
Y <- rbind(temp1, temp2)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

Features <- read.table("Features.txt")
NeededFeatures <- grep("-mean\\(\\)|-std\\(\\)", Features[, 2])
X <- X[, NeededFeatures]
names(X) <- Features[NeededFeatures, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
Clean <- cbind(S, Y, X)
write.table(Clean, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

UniSubj <- unique(S)[,1]
NumSubj <- length(unique(S)[,1])
NumActivities <- length(activities[,1])
NumCol <- dim(Clean)[2]
result <- Clean[1:(NumSubj*NumActivities), ]

row = 1
for (s in 1:NumSubj) {
  for (a in 1:NumActivities) {
    result[row, 1] = UniSubj[s]
    result[row, 2] = activities[a, 2]
    temp <- Clean[Clean$subject==s & Clean$activity==activities[a, 2], ]
    result[row, 3:NumCol] <- colMeans(temp[, 3:NumCol])
    row = row+1
  }
}
write.table(result, "tidy_data_w_averages.txt", row.names = FALSE)
