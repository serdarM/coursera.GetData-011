# Getting & Cleaning Data (getdata-011) Course Project - CodeBook #
This document describes the variable names referenced in the project. 
It consists of two sections: `feature.clean.txt` (the pre-processing done on one of raw data files to make the output R-friendly and typo-free) and `tidyData.txt` (the output file).


## feature.clean.txt ##
The experiment that forms the basis of this data analysis project outputs 561 measures for each subject's activity tracked.  These measures, referred to as "features" are explained in detail in the `features_info.txt` file that comes as part of the raw data set.  Unfortunately, the `features.txt` file that is used for the observation reporting derived from the `features_info.txt` is not as clean as we want it to be: 

- Feature names are illegal as variable names in R as they contain the symbols "-","(", and ")"
- There are also some names, potentially typos, that do not match the feature_info detail provided by the researches (names with BodyBody).

To ensure that we end up with a clean data-frame, we pre-processed `features.txt` to create `features.clean.txt` using the following steps:

1. Removed all occurrences of "(" and ")"
2. Replaced all occurrences of "-" and "," with "_"
3. Replaced all occurrences of "fBodyBodyAccJerkMag" with "fBodyAccJerkMag", "fBodyBodyGyroMag" with "fBodyGyroMag", and "fBodyBodyGyroJerkMag" with "fBodyGyroJerkMag" to remain consistent with `features_info.txt`

We verified that these amendments do not cause any duplicates nor any loss in information and the resultant file is equally valid for the purpose of reporting.


## tidyData.txt ##
This is the output file as outlined in the project brief.  It contains one row of observation for each & every activity performed by each & every subject in the experiment.  For every feature presented, the value is the mean of all the measurements for that particular subject performing that particular activity.  For example, there are 54 observations for subject #2 and his/her STANDING activity for all the 79 mean & std variables we have in the data set... in tidyData, we present one value for each variable that happens to be the mean of these 54 values in the original data set.

Again, each row represents a single subject and single activity.  The columns in the tidy-data are as follows:

**`Activity`**: Name of the activity performed by the subject.  One of LAYING, SITTING, STANDING, WALKING,  WALKING_DOWNSTAIRS, or WALKING_UPSTAIRS

**`Subject`**: Identifier for the subject of the experiment.  A number between 1 and 30.

The detail for the rest of the columns are based on the experiment's `features_info.txt` file:
> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
> 
> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
> 
**> tBodyAcc-XYZ**
> 
**> tGravityAcc-XYZ**
> 
**> tBodyAccJerk-XYZ**
> 
**> tBodyGyro-XYZ**
> 
**> tBodyGyroJerk-XYZ**
> 
**> tBodyAccMag**
> 
**> tGravityAccMag**
> 
**> tBodyAccJerkMag**
> 
**> tBodyGyroMag**
> 
**> tBodyGyroJerkMag**
> 
**> fBodyAcc-XYZ**
> 
**> fBodyAccJerk-XYZ**
> 
**> fBodyGyro-XYZ**
> 
**> fBodyAccMag**
> 
**> fBodyAccJerkMag**
> 
**> fBodyGyroMag**
> 
**> fBodyGyroJerkMag**

For every pattern, multiple values are calculated.  For us, the ones of concern are:
>
**> mean: Mean value**
> 
**> std: Standard deviation**
> 
**> meanFreq: Weighted average of the frequency components to obtain a mean frequency**


The rest of our columns are essentially valid & meaningful combinations in the form: `$PATTERN_$MEASURE($DIR)` where `$PATTERN` is one of the **t*** or **f*** patterns in the first set, `$MEASURE` is the calculation in the second set, and `$DIR` is one of **X**, **Y**, or **Z** if the pattern is related to an axial signal.  They are all normalized and takes values in the [-1,1] range.

As such, the remaining columns are:

     tBodyAcc_meanX
     tBodyAcc_meanY
     tBodyAcc_meanZ
     tBodyAcc_stdX
     tBodyAcc_stdY
     tBodyAcc_stdZ
     tGravityAcc_meanX
     tGravityAcc_meanY
     tGravityAcc_meanZ
     tGravityAcc_stdX
     tGravityAcc_stdY
     tGravityAcc_stdZ
     tBodyAccJerk_meanX
     tBodyAccJerk_meanY
     tBodyAccJerk_meanZ
     tBodyAccJerk_stdX
     tBodyAccJerk_stdY
     tBodyAccJerk_stdZ
     tBodyGyro_meanX
     tBodyGyro_meanY
     tBodyGyro_meanZ
     tBodyGyro_stdX
     tBodyGyro_stdY
     tBodyGyro_stdZ
     tBodyGyroJerk_meanX
     tBodyGyroJerk_meanY
     tBodyGyroJerk_meanZ
     tBodyGyroJerk_stdX
     tBodyGyroJerk_stdY
     tBodyGyroJerk_stdZ
     tBodyAccMag_mean
     tBodyAccMag_std
     tGravityAccMag_mean
     tGravityAccMag_std
     tBodyAccJerkMag_mean
     tBodyAccJerkMag_std
     tBodyGyroMag_mean
     tBodyGyroMag_std
     tBodyGyroJerkMag_mean
     tBodyGyroJerkMag_std
     fBodyAcc_meanX
     fBodyAcc_meanY
     fBodyAcc_meanZ
     fBodyAcc_stdX
     fBodyAcc_stdY
     fBodyAcc_stdZ
     fBodyAcc_meanFreqX
     fBodyAcc_meanFreqY
     fBodyAcc_meanFreqZ
     fBodyAccJerk_meanX
     fBodyAccJerk_meanY
     fBodyAccJerk_meanZ
     fBodyAccJerk_stdX
     fBodyAccJerk_stdY
     fBodyAccJerk_stdZ
     fBodyAccJerk_meanFreqX
     fBodyAccJerk_meanFreqY
     fBodyAccJerk_meanFreqZ
     fBodyGyro_meanX
     fBodyGyro_meanY
     fBodyGyro_meanZ
     fBodyGyro_stdX
     fBodyGyro_stdY
     fBodyGyro_stdZ
     fBodyGyro_meanFreqX
     fBodyGyro_meanFreqY
     fBodyGyro_meanFreqZ
     fBodyAccMag_mean
     fBodyAccMag_std
     fBodyAccMag_meanFreq
     fBodyAccJerkMag_mean
     fBodyAccJerkMag_std
     fBodyAccJerkMag_meanFreq
     fBodyGyroMag_mean
     fBodyGyroMag_std
     fBodyGyroMag_meanFreq
     fBodyGyroJerkMag_mean
     fBodyGyroJerkMag_std
     fBodyGyroJerkMag_meanFreq
    
