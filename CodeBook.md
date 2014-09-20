# CodeBook


## Background:
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. Here's a sample [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/).  
The University of California Irvine, at their Center for Machine Learning and Intelligence Systems has published a Data Set about Human Activity Recognition Using Smartphones. This CodeBook describes the transformations and filterings done on that Data Set and the variables of the resulting Tidy Data Set.


## Raw Data:
Raw data was collected from the accelerometers from the Samsung Galaxy S II smartphone, and was downloaded for this analysis from this [URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  
A full description of the data is available at the [UCI Machine Learning Repository Site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), including a CodeBook for the Raw data variables.   


## Processing
With the goal of generating a Tidy Data Set, a series of transformation and subsettings are executed over the Raw Data Set. These are the steps followed:

1.  **The following Raw Data Set files are read**:
    "./UCI HAR Dataset/activity_labels.txt"  
    "./UCI HAR Dataset/features.txt"  
    "./UCI HAR Dataset/train/X_train.txt"  
    "./UCI HAR Dataset/train/subject_train.txt"  
    "./UCI HAR Dataset/train/y_train.txt"  
    "./UCI HAR Dataset/test/X_test.txt"  
    "./UCI HAR Dataset/test/subject_test.txt"  
    "./UCI HAR Dataset/test/y_test.txt"  
After reading these files we obtain: a 561-feature vector with time and frequency domain variables (numeric), its activity label (integer) and an identifier of the subject who carried out the experiment (integer), split in two separate Data Sets: test and train. In addition it is also collected the 561 feature variable names (features.txt) and the 6 activity label names to be used to produce tidy data. The rest of the variables and data from the raw data package are ignored.  
The complete list of Feature Variables can be consulted in a separated CodeBook in the Raw Data Set package referenced in the "Raw Data" section of this guide. The full definition of all the raw data variables and where they come from is also described in that CodeBook and can be consulted there.  
It is important to highlight that Features are normalized and bounded within [-1,1]. This normalization cancel the units.
     + **Once all raw data is collected, it is combined it together.**
    As described and illustrated in detaill in the README file of this repository, the data we are processing does not contain any big irregularity that we must correct to obtain a tidy data set. All feature variables are independent variables, and all rows are separated observations. Because of those reasons and the fact that all input data sets fit together clipping them in the right order (see README file diagram), no merge or join was executed in this step.  
    The result of this clipping is a single data set with the activity label, subject id and the 561 feature variables, containing 10299 observations (together the train and the test sets)
    Additionally we use import the raw data feature variable names (character) and use it in our data set column names.

2.  **Subsetting of the data set**
Subsetting to keep only the variables that represent measurements on the mean and standard deviation: 66 variables, together with the activity and subject.

3.  **Using descriptive activity names**
Altering the activity variable (IDs from 1 to 6) and replacing all the IDs with their corresponding descriptive Activity Names, previously read from the raw data files. Thus changing this column from integer to character.

4.  **Appropriately label the data set with descriptive variable names.**
A series of tweaks are executed on the variable names to make there more descriptive and readable, beyond what was done already on step #1:
    * remove parenthesis "()"
    * remove double "Body" words
    * more descriptive prefix "freq" instead of "f" for frequency domain signals
    * more descriptive prefix "time" instead of "t" for time domain signals
    * mean with capital M
    * std replaced with StandardDev for clarity
    * X turned into Xaxis for X axis indicator
    * Y turned into Xaxis for Y axis indicator
    * Z turned into Xaxis for Z axis indicator
    * replace "hyphon" with "underscode" for clarity
All names can be consulted at the end of this Code Book

5. **Creation of a final Tidy Data Set with the average of each variable for each activity and each subject**
Until here, the 561 feature variables have remained untouched with no changes, only a subsetting (filtering) of some of them has been executed over this set. Before this step we have 10299-row deep data set with observations of these 561 features on 6 activities and by 30 different subjects. What we will produce in this step is a Tidy Data Set averaging each feature variable for each activity and subject.  
To do this we will proceed with melting of all feature variables and subsequent casting of all of them executing in the way a single aggregation (mean).
The result Data Set is wide and short: it and contains the same 561 feature variables (numeric) plus the activity (character) and subject (integer), and it has as much as 180 rows (30 subjects by 6 activities). Each row is now the average of all raw observations on this 561 variables for each combination of activity and subject.
This result seems a satisfactory Tidy Data Set according to Hadley Wickham's Tiday data paper and the rules in it:
    + Each variable forms a column.
    + Each observation forms a row.
    + Each type of observational unit forms a table.
This set seems to be also free of the common errors detailed in that paper.

6.  **Write tidy data set into tidy.txt file.**
Last step in this proces is to output the Tidy Data Set into a file called tidy.txt


## Tidy Data Dictionary:

| Variable                            | Range                                                               | Description                                                                 |
|-------------------------------------|---------------------------------------------------------------------|-----------------------------------------------------------------------------|
| activity_name                       | WALKING|WALKING_UPSTAIRS|WALKING_DOWNSTAIRS|SITTING|STANDING|LAYING | Activity Name                                                               |
| subject_identifier                  | [1,6]                                                               | Subject Identifier                                                          |
| Time_BodyAcc_Mean_Xaxis             | [-1,1]                                                              | Mean Time Domain Body Acceleration Signal on X axis                         |
| Time_BodyAcc_Mean_Yaxis             | [-1,1]                                                              | Mean Time Domain Body Acceleration Signal on Y axis                         |
| Time_BodyAcc_Mean_Zaxis             | [-1,1]                                                              | Mean Time Domain Body Acceleration Signal on Z axis                         |
| Time_GravityAcc_Mean_Xaxis          | [-1,1]                                                              | Mean Time Domain Gravity  Acceleration Signal on X axis                     |
| Time_GravityAcc_Mean_Yaxis          | [-1,1]                                                              | Mean Time Domain Gravity Acceleration Signal on Y axis                      |
| Time_GravityAcc_Mean_Zaxis          | [-1,1]                                                              | Mean Time Domain Gravity Acceleration Signal on Z axis                      |
| Time_BodyAccJerk_Mean_Xaxis         | [-1,1]                                                              | Mean Time Domain Body Acceleration Jerk Signal on X axis                    |
| Time_BodyAccJerk_Mean_Yaxis         | [-1,1]                                                              | Mean Time Domain Body Acceleration Jerk Signal on Y axis                    |
| Time_BodyAccJerk_Mean_Zaxis         | [-1,1]                                                              | Mean Time Domain Body Acceleration Jerk Signal on Z axis                    |
| Time_BodyGyro_Mean_Xaxis            | [-1,1]                                                              | Mean Time Domain Body Gyroscope Signal on X axis                            |
| Time_BodyGyro_Mean_Yaxis            | [-1,1]                                                              | Mean Time Domain Body Gyroscope Signal on Y axis                            |
| Time_BodyGyro_Mean_Zaxis            | [-1,1]                                                              | Mean Time Domain Body Gyroscope Signal on Z axis                            |
| Time_BodyGyroJerk_Mean_Xaxis        | [-1,1]                                                              | Mean Time Domain Body Gyroscope Jerk Signal on X axis                       |
| Time_BodyGyroJerk_Mean_Yaxis        | [-1,1]                                                              | Mean Time Domain Body Gyroscope Jerk Signal on Y axis                       |
| Time_BodyGyroJerk_Mean_Zaxis        | [-1,1]                                                              | Mean Time Domain Body Gyroscope Jerk Signal on Z axis                       |
| Time_BodyAccMag_Mean                | [-1,1]                                                              | Mean Time Domain Body Acceleration Magnitude Signal                         |
| Time_GravityAccMag_Mean             | [-1,1]                                                              | Mean Time Domain Body Gravity Acceleration Magnitude Signal                 |
| Time_BodyAccJerkMag_Mean            | [-1,1]                                                              | Mean Time Domain Body Acceleration Jerk Magnitude Signal                    |
| Time_BodyGyroMag_Mean               | [-1,1]                                                              | Mean Time Domain Body Gyroscope Magnitude Signal                            |
| Time_BodyGyroJerkMag_Mean           | [-1,1]                                                              | Mean Time Domain Body Gyroscope Jerk Magnitude Signal                       |
| Freq_BodyAcc_Mean_Xaxis             | [-1,1]                                                              | Mean Frequency Domain Body Acceleration Signal on X axis                    |
| Freq_BodyAcc_Mean_Yaxis             | [-1,1]                                                              | Mean Frequency Domain Body Acceleration Signal on Y axis                    |
| Freq_BodyAcc_Mean_Zaxis             | [-1,1]                                                              | Mean Frequency Domain Body Acceleration Signal on Z axis                    |
| Freq_BodyAccJerk_Mean_Xaxis         | [-1,1]                                                              | Mean Frequency Domain Body Acceleration Jerk Signal on X axis               |
| Freq_BodyAccJerk_Mean_Yaxis         | [-1,1]                                                              | Mean Frequency Domain Body Acceleration Jerk Signal on Y axis               |
| Freq_BodyAccJerk_Mean_Zaxis         | [-1,1]                                                              | Mean Frequency Domain Body Acceleration Jerk Signal on Z axis               |
| Freq_BodyGyro_Mean_Xaxis            | [-1,1]                                                              | Mean Frequency Domain Body Gyroscope Signal on X axis                       |
| Freq_BodyGyro_Mean_Yaxis            | [-1,1]                                                              | Mean Frequency Domain Body Gyroscope Signal on Y axis                       |
| Freq_BodyGyro_Mean_Zaxis            | [-1,1]                                                              | Mean Frequency Domain Body Gyroscope Signal on Z axis                       |
| Freq_BodyAccMag_Mean                | [-1,1]                                                              | Mean Frequency Domain Body Acceleration Magnitude Signal                    |
| Freq_BodyAccJerkMag_Mean            | [-1,1]                                                              | Mean Frequency Domain Body Acceleration Jerk Magnitude Signal               |
| Freq_BodyGyroMag_Mean               | [-1,1]                                                              | Mean Frequency Domain Body Gyroscope Magnitude Signal                       |
| Freq_BodyGyroJerkMag_Mean           | [-1,1]                                                              | Mean Frequency Domain Body Gyroscope Jerk Magnitude Signal                  |
| Time_BodyAcc_StandardDev_Xaxis      | [-1,1]                                                              | Standard Deviation Time Domain Body Acceleration Signal on X axis           |
| Time_BodyAcc_StandardDev_Yaxis      | [-1,1]                                                              | Standard Deviation Time Domain Body Acceleration Signal on Y axis           |
| Time_BodyAcc_StandardDev_Zaxis      | [-1,1]                                                              | Standard Deviation Time Domain Body Acceleration Signal on Z axis           |
| Time_GravityAcc_StandardDev_Xaxis   | [-1,1]                                                              | Standard Deviation Time Domain Gravity  Acceleration Signal on X axis       |
| Time_GravityAcc_StandardDev_Yaxis   | [-1,1]                                                              | Standard Deviation Time Domain Gravity Acceleration Signal on Y axis        |
| Time_GravityAcc_StandardDev_Zaxis   | [-1,1]                                                              | Standard Deviation Time Domain Gravity Acceleration Signal on Z axis        |
| Time_BodyAccJerk_StandardDev_Xaxis  | [-1,1]                                                              | Standard Deviation Time Domain Body Acceleration Jerk Signal on X axis      |
| Time_BodyAccJerk_StandardDev_Yaxis  | [-1,1]                                                              | Standard Deviation Time Domain Body Acceleration Jerk Signal on Y axis      |
| Time_BodyAccJerk_StandardDev_Zaxis  | [-1,1]                                                              | Standard Deviation Time Domain Body Acceleration Jerk Signal on Z axis      |
| Time_BodyGyro_StandardDev_Xaxis     | [-1,1]                                                              | Standard Deviation Time Domain Body Gyroscope Signal on X axis              |
| Time_BodyGyro_StandardDev_Yaxis     | [-1,1]                                                              | Standard Deviation Time Domain Body Gyroscope Signal on Y axis              |
| Time_BodyGyro_StandardDev_Zaxis     | [-1,1]                                                              | Standard Deviation Time Domain Body Gyroscope Signal on Z axis              |
| Time_BodyGyroJerk_StandardDev_Xaxis | [-1,1]                                                              | Standard Deviation Time Domain Body Gyroscope Jerk Signal on X axis         |
| Time_BodyGyroJerk_StandardDev_Yaxis | [-1,1]                                                              | Standard Deviation Time Domain Body Gyroscope Jerk Signal on Y axis         |
| Time_BodyGyroJerk_StandardDev_Zaxis | [-1,1]                                                              | Standard Deviation Time Domain Body Gyroscope Jerk Signal on Z axis         |
| Time_BodyAccMag_StandardDev         | [-1,1]                                                              | Standard Deviation Time Domain Body Acceleration Magnitude Signal           |
| Time_GravityAccMag_StandardDev      | [-1,1]                                                              | Standard Deviation Time Domain Body Gravity Acceleration Magnitude Signal   |
| Time_BodyAccJerkMag_StandardDev     | [-1,1]                                                              | Standard Deviation Time Domain Body Acceleration Jerk Magnitude Signal      |
| Time_BodyGyroMag_StandardDev        | [-1,1]                                                              | Standard Deviation Time Domain Body Gyroscope Magnitude Signal              |
| Time_BodyGyroJerkMag_StandardDev    | [-1,1]                                                              | Standard Deviation Time Domain Body Gyroscope Jerk Magnitude Signal         |
| Freq_BodyAcc_StandardDev_Xaxis      | [-1,1]                                                              | Standard Deviation Frequency Domain Body Acceleration Signal on X axis      |
| Freq_BodyAcc_StandardDev_Yaxis      | [-1,1]                                                              | Standard Deviation Frequency Domain Body Acceleration Signal on Y axis      |
| Freq_BodyAcc_StandardDev_Zaxis      | [-1,1]                                                              | Standard Deviation Frequency Domain Body Acceleration Signal on Z axis      |
| Freq_BodyAccJerk_StandardDev_Xaxis  | [-1,1]                                                              | Standard Deviation Frequency Domain Body Acceleration Jerk Signal on X axis |
| Freq_BodyAccJerk_StandardDev_Yaxis  | [-1,1]                                                              | Standard Deviation Frequency Domain Body Acceleration Jerk Signal on Y axis |
| Freq_BodyAccJerk_StandardDev_Zaxis  | [-1,1]                                                              | Standard Deviation Frequency Domain Body Acceleration Jerk Signal on Z axis |
| Freq_BodyGyro_StandardDev_Xaxis     | [-1,1]                                                              | Standard Deviation Frequency Domain Body Gyroscope Signal on X axis         |
| Freq_BodyGyro_StandardDev_Yaxis     | [-1,1]                                                              | Standard Deviation Frequency Domain Body Gyroscope Signal on Y axis         |
| Freq_BodyGyro_StandardDev_Zaxis     | [-1,1]                                                              | Standard Deviation Frequency Domain Body Gyroscope Signal on Z axis         |
| Freq_BodyAccMag_StandardDev         | [-1,1]                                                              | Standard Deviation Frequency Domain Body Acceleration Magnitude Signal      |
| Freq_BodyAccJerkMag_StandardDev     | [-1,1]                                                              | Standard Deviation Frequency Domain Body Acceleration Jerk Magnitude Signal |
| Freq_BodyGyroMag_StandardDev        | [-1,1]                                                              | Standard Deviation Frequency Domain Body Gyroscope Magnitude Signal         |
| Freq_BodyGyroJerkMag_StandardDev    | [-1,1]                                                              | Standard Deviation Frequency Domain Body Gyroscope Jerk Magnitude Signal    |