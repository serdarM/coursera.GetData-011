
# Getting & Cleaning Data (getdata-011) Course Project- ReadMe #
This guide describes how the "tidy data set" for the course project was created. 


## Background ##
The analysis is based on the Human Activity Recognition (HAR) study conducted by researchers at Smartlab - Non Linear Complex Systems Laboratory of Genoa University in Italy.  The full description of the process by which the data was acquired & pre-processed, along with the full set of data generated, can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Out of the raw data available as a result of these experiments *(about 270 MB of measurements and calculations presented in two sets of 12 separate files, one set for `test` and the other for 
`train`ing)*, following are the relevant ones for the purposes of our project:

- **`features.txt`**: List of all 561 features that make up an observation.  *We will be interested in a subset of these.*
- **`activity_labels.txt`**: Labels for the activity names.  *We will need this for "descriptive" labeling in tidy data.*

- **`test/X_test.txt`**: Test set. 2947 rows of observations with each row containing 561 values for each feature.
- **`test/y_test.txt`**: Test labels. 2947 rows of activity labels corresponding to each observation in `X_test.txt`.
- **`test/subject_test.txt`**: Subject id's. 2947 rows of id's, each identifying the subject who performed the activity in `X_test.txt`.

- **`train/X_train.txt`**: Training set. Similar to `X_test.txt`, this time with 7352 rows of observations.
- **`train/y_train.txt`**: Training labels. Similar to `y_test.txt`, this time for the 7352 training observations.
- **`train/subject_train.txt`**: Subject id's. Similar to `subject_test.txt`, this time for the 7352 training observations.

These are the raw data we will be working with.  Please be sure that these files are available in the `UCI HAR Dataset` directory (with its `test` and `train` sub-directories) under the working directory.  A simple extraction of the zip file presented in the project brief should enable this.


## Process ##
With the source files in `UCI HAR Dataset` directory (i.e. the "raw data") in order, we can follow the steps in the project brief to get to our target tidy data.

Steps (and related details) are as follows:

**> Step1. Merge the training and the test sets to create one data set.**

The main goal here is to bring together the observations under `test` and `train` directories under one *uber-data-frame* with which we can work with.  While we are doing this, we can add proper column labels and descriptive names so that the output data-frame is more descriptive than the raw text files we started with.

This is essentially column-binding (a) the subject list in the `subject_*.txt` files, (b) the activities in the `y_*.txt` files, and (c) the observations in the `X_*.txt` files for both * = `test` and * = `train`.  Once this is done, we row-bind the two data frames to create the aforementioned *uber-data-frame*.

Here are some areas that require attention while doing this:

- Add column labels to each data-frame read from an individual file as we go along.
- subject data-frames gets *"subject"* as the column header
- activity labels data-frames get *"activityId"* as the column header; we also add the corresponding *"activityName"*s in a newly added column utilizing the `activity_labels.txt` file
- the X data-frames, i.e. the observations, get the list of feature names from the `features.txt` file
	- It turns out that the `features.txt` file contains feature names that are illegal as variable names in R as they contain the symbols "-","(", and ")". There are also some names, potentially typos, that do not match the feature_info detail provided by the researches (names with BodyBody).
	- Following along the lines of [our community TA's suggestion](https://class.coursera.org/getdata-011/forum/thread?thread_id=69#comment-713), I created a `features.clean.txt` file and used that file instead. The steps in creating this processed file is detailed in the CodeBook.
	
As a result of these steps, we come up with a data-frame with a combined **10,299 observations** (2947 from test + 7352 from train) with **564 variables** (*subject*, *activityId*, and *activityLabel* added to the 561 features in the `X_*.txt` files).

	
**> Step2. Extract only the measurements on the mean and standard deviation for each measurement.**

By using the grepl() function, we can get a logical vector with a TRUE for each occurrence of "mean" or "std" and FALSE otherwise.  We use this vector to create a subset of the data-frame above that only has the columns that we are interested in.  The resulting data-frame still has 10,299 observations, but this time with only the features that we are interested in, the means and the standard deviations.  Result is a data-frame with **10,299 observations** with **82 variables** (79 mean & std, plus the three columns introduced with the column binding in Step1.).  


**> Step3. Use descriptive activity names to name the activities in the data set.**

This actually was handled as we were column-binding the activity labels to the X data-frames.  Note that, the 82 variables we have in the latest data-frame has both the *activityId* and *activityLabel* columns.

  
**> Step4. Appropriately label the data set with descriptive variable names.**

Similarly, this was also completed in Step1 when we introduced the subject and activity data-frames and row-bound them to the observations using the feature names from the processed the `features.clean.txt` file, all with proper column headers.  While the feature names may look cryptic to the casual observer, they follow an intuitive encoding rule based on the signals and measurements related to those (this is covered in further detail in the CodeBook).
 

**> Step5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.**

The 10,299 observations referenced above, and available in our uber-data-frame, contain multiple measurements for the same subject performing the same activity.  For example, there are 54 observations for subject #2 during his/her activity #5 (i.e. STANDING).  

The goal for this final step is to summarize the data such that we have only one row for each subject and each activity performed by that subject.  Considering there were 30 subjects in the study, all of which performed the full set of 6 tasks, what we need to get to is a 180 observation data-frame, one row for each i and j where i is the list of activities (1:6) and j is the list of subjects (1:30).

This is done quite easily using the `aggregate()` function where we start with our uber-data-frame, group by the "activityName" and "subject" as factors, and take a mean of the observations.  In other words, for the example above the function takes the mean of 54 observations for subject #2 and his/her STANDING activity for all the 79 mean & std variables we have in the data set.  The `aggregate()` function does this for all i,j combinations mentioned above in one step, creating a data-frame with 180 observations and 84 variables (+2 columns inserted for the i,j combinations).

After cleaning up the final summary data-frame by getting rid of the dupe columns that we don't need and ordering first by Activity and then by Subject, we get our tidy-data with **180 observations** and **81 variables**.  The last step is to write this into a text file (`tidyData.txt`) for future use (and project submission!).

Due to the size of the columns, it is best to use the R call `read.table("tidyData.txt", header = TRUE)` to read the file as opposed to opening it in Notepad++ / TextWrangler (acceptable) or Notepad (not a good idea).  

**ENJOY!**




----------
License:
The dataset used in this project is associated with the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
