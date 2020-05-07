library(dplyr)

# Sets the working directory where the data is stored
WD <- getwd()
setwd(WD)

#setwd("/Users/Marcela/Documents/R/Data/Course_3_Project")

# URL address with the data for the project
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

dest_file <- paste(WD, "/Dataset.zip", sep = "")
download.file(url, dest_file)

unzip(dest_file)

# Read the data and the labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_number", "activity_label"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("number", "feature"))

# Read test set
x_test <-  read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
y_test <-  read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_number")
subject_test <-  read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# Read train set
x_train <-  read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
y_train <-  read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_number")
subject_train <-  read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

# Merge test and train data sets
x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)
data_set <- cbind(subject, y, x)

# The variable data_set contains the training and test sets with descriptive
# activity names and descriptive variable names
data_set <- merge(activity_labels, data_set, by = "activity_number")
data_set$activity_number <- NULL

# Descriptive variable names
names(data_set) <- gsub("^t", "Time", names(data_set))
names(data_set) <- gsub("^f", "Frequency", names(data_set))
names(data_set) <- gsub("Acc", "Accelerometer", names(data_set))
names(data_set) <- gsub("Gyro", "Gyroscope", names(data_set))
names(data_set) <- gsub("Mag", "Magnitude", names(data_set))
names(data_set) <- gsub("BodyBody", "Body", names(data_set))

# Index gets the position of all the variables that contain measurements on the
# mean and standard deviation
index <- grep("\\mean|std", features[,2]) + 2

# Extracts a new data set, named data_set_2. It is exported as a .txt file named
# tidy_data_set_1.txt with only the measurements of mean and standard deviation
data_set_2 <- data_set[,c(1,2,index)]
write.table(data_set_2, file = paste(WD, "/tidy_data_set_1.txt", sep = ""), row.name=FALSE)

# Data set with the average of each variable for each activity and each subject. It is named
# data_set_3 and is exported as tidy_data_set_2.txt
data_set_3 <- group_by(data_set_2, activity_label, subject) %>% summarise_each(funs(mean))
write.table(data_set_3, file = paste(WD, "/tidy_data_set_2.txt", sep = ""), row.name=FALSE)
