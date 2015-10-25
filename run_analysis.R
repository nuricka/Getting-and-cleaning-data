#====================================
# Getting and cleaning data-Project1
#====================================

#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#1-Merges the training and the test sets to create one data set.
#2-Extracts only the measurements on the mean and standard deviation for each measurement. 
#3-Uses descriptive activity names to name the activities in the data set
#4-Appropriately labels the data set with descriptive variable names. 
#5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Download to your working directory
#-----------------------------------
setwd("F:/Coursera/3.-Getting and cleaning data/")
# set your working directory with the setwd("path") comand
if (!dir.exists("./final project")) {
  dir.create("./final project")
}
setwd("./final project")
# Download, unzip the files and remove the zip file
if (!file.exists("Dataset.zip")) {
  urlfile<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(urlfile, "./Dataset.zip") 
  unzip("Dataset.zip", list = FALSE, exdir=".", overwrite = TRUE)
  file.remove("Dataset.zip")
}
#install.packages("downloader")
#library(downloader)


# Read files
#-----------------------------------
# We have to choose from the train dataset those features on the mean and standard deviation for each measurement. 
# To do that, we subset the features.txt names related to mean() and std() estimators and use the row numbers to select the columns on the train dataset.
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)
features <- read.table("UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
features$V2 <- gsub('[-()]', '', features$V2)
features$V2 <- gsub('std', 'Std', features$V2)
features$V2 <- gsub('mean', 'Mean', features$V2)
subsetfeatures <- grep(".*Mean.*|.*Std.*", features$V2)
features$V2[subsetfeatures]

# x_test and x_train cointain the test and training set information of all the features (561 variables). 
# We subset the columns containing the mean ans std measurements
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")[subsetfeatures]
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")[subsetfeatures]

# Activities (names(table(activity_labels$V2)) => "LAYING","SITTING","STANDING","WALKING","WALKING_DOWNSTAIRS","WALKING_UPSTAIRS")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt") 

# subject_test and subject_train identify the subjects performing each of the activities
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# We merge the datasets
# 1-Combine the variables (subject, activities and measurements) of test and train dataset
test<-cbind(subject_test,y_test,x_test)
train<-cbind(subject_train,y_train,x_train)
# 2-We join test and train dataset
complete<-rbind(test,train)
names(complete)<-c("Subject","Activity",features$V2[features$V1%in%c(subsetfeatures)])
complete$Subject <- as.factor(complete$Subject)
complete$Activity<-factor(complete$Activity,levels=activity_labels$V1,labels=activity_labels$V2)
library(dplyr)
complete <- arrange(complete, Subject,Activity)

# tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
complete.melt <- melt(complete, id = c("Subject", "Activity"))
complete.mean <- dcast(complete.melt, Subject + Activity ~ variable, mean)

write.table(complete.mean, "tidy.txt", row.names = FALSE, quote = FALSE)

