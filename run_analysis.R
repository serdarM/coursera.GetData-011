## Perform the analysis in 5 steps as described in the project brief.


## STEP1: Pull all the data that we need into data frames (adding column labels
## using "names" calls and descriptive names as we go along) so we can merge
## them into an uber-data set for our project

features <- read.table("./UCI HAR Dataset/features.clean.txt")[,2]
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

xTest <- read.table("./UCI HAR Dataset/test/X_test.txt") ## observations
names(xTest) <- features

yTest <- read.table("./UCI HAR Dataset/test/y_test.txt") ## activity labels
names(yTest) <- "activityId"
yTest$activityName <- activities[yTest[,1]] ## new column with activity name

subjTest <- read.table("./UCI HAR Dataset/test/subject_test.txt") ## subjects
names(subjTest) <- "subject"

xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt") ## observations
names(xTrain) <- features

yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt") ## activity labels
names(yTrain) <- "activityId"
yTrain$activityName <- activities[yTrain[,1]] ## new column with activity name

subjTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt") ## subjects
names(subjTrain) <- "subject"

## we'll merge the columns in each set first, then row-bind to create full set
testData <- cbind(subjTest, yTest, xTest)
trainingData <- cbind(subjTrain, yTrain, xTrain)
fullData <- rbind(testData, trainingData)

## some clean-up of memory (not that it's needed at this day & age ;)
rm(xTest, yTest, subjTest, xTrain, yTrain, subjTrain, testData, trainingData)
## DONE WITH STEP1


## STEP2: Now that we have our merged data set, full set of raw data, let's try
## getting rid of the columns that we won't need for this analysis

keyFeatures <- grepl("mean|std", features)
colFilter <- c(TRUE, TRUE, TRUE, keyFeatures) ## remember the cols we bound
fullData <- fullData[, colFilter] ## data to contain mean&std measures only
## DONE WITH STEP2


## STEP3: Data set should contain descriptive activity names.
## This was done when we processed yTest and yTrain frames above adding the
## ActivityName column
## DONE WITH STEP3


## STEP4: Data set should have descriptive variable names.
## This was also done when we processed the data frames that made up "fullData"
## ... all data frames were given column labels via the "names" calls.
## DONE WITH STEP4


## STEP5: Summarize the data such that there is a single entry/observation for
## each subject-activity pair; i.e. one row for each subjectId i and activityId
## j where i is in 1:30 and j is in 1:6 (or WALKING through LAYING ).  Take the
## average of each column for multiple i-j observations.
summaryData <- aggregate(fullData, list(Activity=fullData$activityName, Subject=fullData$subject), mean)

## Since the Subject and Activity are now aggregated, we can get rid of the
## replicated columns
summaryData[, "subject"] = NULL
summaryData[, "activityId"] = NULL
summaryData[, "activityName"] = NULL

tidyData <- summaryData[order(summaryData$Activity,summaryData$Subject), ]
##... and write to a text file
write.table(tidyData, file="tidyData.txt", row.names=FALSE)
## DONE WITH STEP5

## more clean-up of memory
rm(fullData, summaryData, tidyData)

##
## Please use read.table("tidyData.txt", header = TRUE) in R to read the output.
##