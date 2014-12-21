# Tidied Human Activity Recognition Using Smartphones Dataset

This repository contains the script and the code book that was used to transform the original data located at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

into a tidy dataset that contains the subject, activity and the mean for every variable.

##How to run the script
To run the script use the following process:

1. Save the script in the folder that contains the "UCI HAR Dataset" folder, which is the extracted zip file from the link above.
2. The script uses the following packages, please, make sure you have them installed before running the script:

* dplyr
* tidyr
* reshape2
* sqldf

3. In R execute the following command:
source("run_analysis.R")

The script contains comments on every step of the execution and it follows the 5 tasks as specified in the project definition.

In general, the following is executing:

1. Loading the training data
2. Loading the test data
3. Merging all the data in one dataset
4. Process the features to find only the one that are for mean and std
5. Extract only the values matching those variables
6. Transform the Activity codes in the Activity names, using the activity_labels.txt
7. Change the Labels of the dataset to descriptive names using the features.txt 
8. Create a tidy data that contains the mean of all the variables for a specific Subject and Activity

It will display the finaldata dataset (which is the resulting dataset of all the transformations) in a nice tabulated output.


The resulting file was created with:

write.table(finaldata,"finaldata.txt",row.name=FALSE)

##How to review data
To review the data please use the following commands:

data <- read.table("finaldata.txt", header = TRUE) 

View(data)

This two lines of code were taken from the following location https://class.coursera.org/getdata-016/forum/thread?thread_id=50

##Column selection criteria

The columns were selected to represent the variables as specified in the features_info.txt (extract below):

"These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag
"
