This repository contains a script called run_analysis.R. This script uses the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It is data collected from the accelerometers from the Samsung Galaxy S smartphone. More information on this data set can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script first downloads the dataset and unzips the folder. Then it reads the six different activity labels and the 561 different features, which are diferent variables calculated with the measurements obtained (more detail can be found on the featues_info.txt file).

Then it reads the test and train sets comprised by the measurements, the subject performing them (there were 30 different subjects so it is a number between 1 and 30) and the activity being performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The code initially merges these two datasets to obtain one dataset which has one column for the subject performing the activity (subject), one column for the activity being performed (activity_label) and other 561 columns for each measurement.

The activity being performed is transformed from a number to a descriptive word of the activity (e.g. walking, sitting, laying, etc.). The script also transforms the names of the measurements to give them a more descriptive name. For example:  TimeBodyAccelerometer.mean...X instead of tBodyAcc-mean()-X.

Then with the function grep, the index corresponding to the columns that contain measurements of the mean and standard deviation is extracted.

With this index, a second data set, named data_set_2 is created and it contains the subject, the activity label and the 79 variables that contain measurements on the mean and standard deviation. This dataset is exported as tidy_data_set_1.txt.

Finally, a third dataset is created. It calculates the average of each variable for each activity and each subject.
It uses the function group_by from the dplyr library to group by activity label and subject and then the function summarise_each to calculate the mean of each column based on this grouping. It is named data_set_3 and is exported as tidy_data_set_2.txt
