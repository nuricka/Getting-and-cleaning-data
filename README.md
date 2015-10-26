# Getting-and-cleaning-data

---
title: "CodeBook.md"
output: html_document
---

#_run_analysis.R_
Creates project1 dir if it doesn't already exists
Download data to your working directory/project1 path (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Unzip and extract the files and remove the zip archive
Reads the datasets:
## Information files:
features.txt contains the names of the columns for the x_test & x_train datasets
activity_labels.txt contains the activity labels
## Subjects:
subject_train.txt, subject_test.txt
## Activities the subjects were performing
y_train, y_test
## Recorded measurements for each subject in each activity:
X_train.txt, x_test.txt

We load the datasets and subset the measurements by selecting the columns containing mean or std estimations
To do that we filter the features dataset and use the selected rows to filter the columns from x measurements file

We create the test and train datasets by merging their files (subject, activity and measurements)
train
test
Then we create a dataset complete, joining the train and the test files

Melt the final data set to be able to compute the average 
Finally we compute the average for each Subject, Activity and Measurement

The final dataset complete.mean contains the id variables (Subject, Activity) and all the measurements (N=86 variables)


names(complete.mean)
  
     [1] "Subject"                            "Activity"                           "tBodyAccMeanX"                     
     [4] "tBodyAccMeanY"                      "tBodyAccMeanZ"                      "tBodyAccStdX"                      
     [7] "tBodyAccStdY"                       "tBodyAccStdZ"                       "tGravityAccMeanX"                  
    [10] "tGravityAccMeanY"                   "tGravityAccMeanZ"                   "tGravityAccStdX"                   
    [13] "tGravityAccStdY"                    "tGravityAccStdZ"                    "tBodyAccJerkMeanX"                 
    [16] "tBodyAccJerkMeanY"                  "tBodyAccJerkMeanZ"                  "tBodyAccJerkStdX"                  
    [19] "tBodyAccJerkStdY"                   "tBodyAccJerkStdZ"                   "tBodyGyroMeanX"                    
    [22] "tBodyGyroMeanY"                     "tBodyGyroMeanZ"                     "tBodyGyroStdX"                     
    [25] "tBodyGyroStdY"                      "tBodyGyroStdZ"                      "tBodyGyroJerkMeanX"                
    [28] "tBodyGyroJerkMeanY"                 "tBodyGyroJerkMeanZ"                 "tBodyGyroJerkStdX"                 
    [31] "tBodyGyroJerkStdY"                  "tBodyGyroJerkStdZ"                  "tBodyAccMagMean"                   
    [34] "tBodyAccMagStd"                     "tGravityAccMagMean"                 "tGravityAccMagStd"                 
    [37] "tBodyAccJerkMagMean"                "tBodyAccJerkMagStd"                 "tBodyGyroMagMean"                  
    [40] "tBodyGyroMagStd"                    "tBodyGyroJerkMagMean"               "tBodyGyroJerkMagStd"               
    [43] "fBodyAccMeanX"                      "fBodyAccMeanY"                      "fBodyAccMeanZ"                     
    [46] "fBodyAccStdX"                       "fBodyAccStdY"                       "fBodyAccStdZ"                      
    [49] "fBodyAccMeanFreqX"                  "fBodyAccMeanFreqY"                  "fBodyAccMeanFreqZ"                 
    [52] "fBodyAccJerkMeanX"                  "fBodyAccJerkMeanY"                  "fBodyAccJerkMeanZ"                 
    [55] "fBodyAccJerkStdX"                   "fBodyAccJerkStdY"                   "fBodyAccJerkStdZ"                  
    [58] "fBodyAccJerkMeanFreqX"              "fBodyAccJerkMeanFreqY"              "fBodyAccJerkMeanFreqZ"             
    [61] "fBodyGyroMeanX"                     "fBodyGyroMeanY"                     "fBodyGyroMeanZ"                    
    [64] "fBodyGyroStdX"                      "fBodyGyroStdY"                      "fBodyGyroStdZ"                     
    [67] "fBodyGyroMeanFreqX"                 "fBodyGyroMeanFreqY"                 "fBodyGyroMeanFreqZ"                
    [70] "fBodyAccMagMean"                    "fBodyAccMagStd"                     "fBodyAccMagMeanFreq"               
    [73] "fBodyBodyAccJerkMagMean"            "fBodyBodyAccJerkMagStd"             "fBodyBodyAccJerkMagMeanFreq"       
    [76] "fBodyBodyGyroMagMean"               "fBodyBodyGyroMagStd"                "fBodyBodyGyroMagMeanFreq"          
    [79] "fBodyBodyGyroJerkMagMean"           "fBodyBodyGyroJerkMagStd"            "fBodyBodyGyroJerkMagMeanFreq"      
    [82] "angletBodyAccMean,gravity"          "angletBodyAccJerkMean,gravityMean"  "angletBodyGyroMean,gravityMean"    
    [85] "angletBodyGyroJerkMean,gravityMean" "angleX,gravityMean"                 "angleY,gravityMean"                
    [88] "angleZ,gravityMean"       

The final dataset is saved as tidy.txt and contains:

dim(table(complete.mean$Subject))
    [1] 30 subjects

6 measurements for each subject (one for each activity):

table(complete.mean$Subject) 

    1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 
 
    6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6 
 
And a total of registers and variables of:

dim(complete.mean)

    [1] 180  88
