# run_analysis.R
# Script that collects raw data, cleans it and and prepares a tidy data set to be used for later
# analysis.
#
# Raw data URL used to get the data:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Scripts expects this data already downloaded and unzipped into "./UCI HAR Dataset/"
# Both that folder and this script must be in the working directory for it to work.
#
# Script steps:
#    1. Merges the training and the test sets to create one data set.
#    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#    3. Uses descriptive activity names to name the activities in the data set
#    4. Appropriately labels the data set with descriptive variable names. 
#    5. From the data set in step 4, creates a second, independent tidy data set with the average
#       of each variable for each activity and each subject.
#    6. Write tidy data set into tidy.txt file
#
# SCRIPT REQUIRES "reshape2" and "dplyr" packages loaded!!

# STEP 1
# -> Merges the training and test data sets to create one data set.
# Read data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
# clipping train data together
traindf <- cbind(y_train,subject_train) # left-most variables will be the activities and subjects
traindf <- cbind(traindf,x_train) # features data will go on the right
# clipping test data together
testdf <- cbind(y_test,subject_test) # left-most variables will be the activities and subjects
testdf <- cbind(testdf,x_test) # features data will go on the right
# clipping train + test data together as each row on both data sets is a different observation
# so it needs to go to a separate row in the final big data frame
alldata <- rbind(traindf,testdf)
# name variables(columns) of the big data data frame using the names provided in the 
# features data set: activities and subjects plus the feature names
vnames <- c("activity_name","subject_identifier")
vnames <- c(vnames,as.character(features[,2]))
colnames(alldata) <- vnames

# STEP 2
# -> Extracts only the measurements on the mean and standard deviation for each measurement.
# select only the features that are mean (mean) or standard deviation (std)
extrdata <- select(alldata,
               activity_name,subject_identifier, # required in the tidy data
               contains("mean"),                 # measurements on the mean
               -contains("meanFreq"),            # meanFreq excluded as it is a weigthed average and not exactly a mean
               -contains("angle"),               # angle excluded as the variable does not exactly represent a mean
               contains("std"))                  # measurements on the standard deviation

# STEP 3
# -> Uses descriptive activity names to name the activities in the data set
# Using the names from the activity_labels table, we replace all ids from the activity_name column with
# their corresponding name.
# This should be equivalent to merge both data sets, but I chose mutate+mapvalues for clarity, to have
# only the activity names and not the ids in the resulting data set in 1 step.
descrdata <- mutate(extrdata, 
                    activity_name = mapvalues(activity_name,
                                              as.integer(activity_labels[,1]),  # from 
                                              as.character(activity_labels[,2]) # to
                                              )
                    )


# STEP 4
# -> Appropriately labels the data set with descriptive variable names
# Variable (column) names were already given during STEP 1, to facilitate the extraction
# on STEP 2.
# Here, I will cleanup the variable names from typos and odd characters, and translate some
# names into more descriptive ones.
clean_names <- gsub("()","", colnames(descrdata), fixed=TRUE) # remove parenthesis "()"
clean_names <- gsub("BodyBody","Body", clean_names)           # remove double "Body" words
clean_names <- gsub("^f","Freq_", clean_names)                # more descriptive name for frequency domain signals
clean_names <- gsub("^t","Time_", clean_names)                # more descriptive name for time domain signals
clean_names <- gsub("mean","Mean", clean_names)               # nicer name for Mean
clean_names <- gsub("std","StandardDev", clean_names)         # nicer name for Standard Deviation
clean_names <- gsub("X$","Xaxis", clean_names)                # more descriptive name for X axis indicator
clean_names <- gsub("Y$","Yaxis", clean_names)                # more descriptive name for Y axis indicator
clean_names <- gsub("Z$","Zaxis", clean_names)                # more descriptive name for Z axis indicator
clean_names <- gsub("-","_", clean_names)                     # replacing "hyphon" with "underscode" for clarity
# apply variable names to the data frame
colnames(descrdata) <- clean_names

# STEP 5
# -> From the data set in step 4, creates a second, independent tidy data set with the
#    average of each variable for each activity and each subject
# Melt data frame keeping activity_name and subject_identifier as IDs
meltData <- melt(descrdata,id=c("activity_name","subject_identifier"))
# Summarize all variables with the average for each activity and subject
tidyData <- dcast(meltData,activity_name + subject_identifier ~ variable, fun.aggregate=mean)

# STEP 6
# -> Write tidy data set into tidy.txt file
write.table(tidyData,"./tidy.txt", row.name=FALSE)