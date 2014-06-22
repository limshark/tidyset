#
# 
#       File Name: run_analysis.R
#
#       Author: Prasanna Limaye
#
#       Date Created: June 12, 2014
#
#       Abstract: This file is a R program as required by coursera project for 
#                       Class3 : Cleaning up data
#
#         
#
# As per the Project requirements the purpose is reproduced verbatm here.
#
#  ----------- Start of Quote -----------------------------------------
# The purpose of this project is to demonstrate your ability to 
# collect, work with, and clean a data set. The goal is to 
#  prepare tidy data that can be used for later analysis. You will
# be graded by your peers on a series of yes/no questions related 
# to the project. You will be required to submit: 
#         1) a tidy data set as described below, 
#         2) a link to a Github repository with your script for performing the analysis, 
# and 3) a code book that describes the variables, the data, and any 
#                 transformations or work that you performed to clean up the data 
#                         called CodeBook.md. 
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are 
# connected.
# 
# One of the most exciting areas in all of data science right now is wearable computing - 
#         see for example this article 
# 1) (http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-theworlds-top-sports-brand/). 
# 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most
# advanced algorithms to attract new users. The data linked to from the course 
# website represent data collected from the accelerometers from the Samsung Galaxy 
# S smartphone. 
# 
# A full description is available
# at the site where the data was obtained:
#     
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#               (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
# Here are the data for the project:
#         https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#               (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
# 
# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and
# each subject.
#  ------------------- Quote End
#
#               Algoritm High Level
#               ===================
#
#
#
#       1) Prepare the feature labels
#               read the labels
#               transform the labels to readable format. 
#     
#       2) Extract the column for the Mean and Standard deviation
#
#       3) Read the activity Labels from the file ( Activity ID vs Activity Name)
#
#       4) read the feature extraction table for "Training" and "Testing"
#
#       5) read the subject table for the "training" and "testing" 
#                paste readable labels
#
#       6) read the activity ID table fort "training" and "testing" 
#                paste readable lables
#
#       7) Merge the feature table with activity table to get activity Name for 
#               corresponding activity ID. 
#
#       8) Cbind the "training table" & "test table" for the features, subject 
#               and activitynames
#
#       9)  horizontally bind using rbind the training table and test table to 
#               form the bigData table containing all the stuff. 
#
#       10) create dataset 
#               create a subset of data choosing right columns ( the columns
#               which has means and standard deviation )
#       
#       11) create tidyset 
#               using aggregate function, chose subjectInstance and ActivityName 
#               as factors to get the mean of the variables in tidyset to form
#               the tidyset
#
#       12) Save the file bigData, dataset and tidyset as csv files.
#               these files will be used by tabulated using excel to 
#               the algorithm, dataset and tidyset should match with the analysis
#               done by excel.
#       
#               finally save the tidyset as table in a .txt comma seperated text 
#               format
#
#







#--------------------------------------------------------------
#       1) Prepare the feature labels
#               read the labels
#               transform the labels to readable format. 


featuresLabel <-  read.table("./data/features.txt")
labelsList <- as.character(featuresLabel$V2)

# Beautify the Label 
#       replace  "()"  to "_"
#       do not touch "(somecontent)" 
#       replace "-" with "_"

labelsList <- sapply(labelsList, function(i) { 
        x <- gsub("[(]+[)]+","",i) 
        gsub("-","_",x)
})

labelsList <- as.character(labelsList)


#  --------------------------------------------------------------   
#       2) Extract the column for the Mean and Standard deviation

# get only features for "mean" for mean and "std" for standard deviation
#     by using grep 

# get the indices which has only mean and std words in it. 
#
meanIndex <- grep("mean",labelsList)
stdIndex <- grep("std",labelsList)

# merge these two lists and sort the list 
#
meanOrStdIndex <- meanIndex
meanOrStdIndex <- c(meanOrStdIndex,stdIndex)
meanOrStdIndex <- sort(meanOrStdIndex)
attrIndex <- meanOrStdIndex 
size_attrIndex <- length(attrIndex)


#  -----------------------------------------------------------------------------
#      3) Read the activity Labels from the file ( Activity ID vs Activity Name)
#
#

#  activitiy labels in data/activity_labels.txt
#
activityLabel <- read.table("./data/activity_labels.txt")

# providing meaning ful labels : a) activityID  and b) activityName 

colnames(activityLabel) <- c("activityID", "activityName")


#--------------------------------------------------------------------------
#       4) read the feature extraction table for "Training" and "Testing"
#



# read the features in the memory  

testFeatures <-  read.table("./data/test/X_test.txt")
trainFeatures <- read.table("./data/train/X_train.txt")

# Neatly Bind the meaningful labels to these features

colnames(testFeatures) <- labelsList
colnames(trainFeatures) <- labelsList




#-------------------------------------------------------------------------
#       5) read the subject table for the "training" and "testing" 
#                paste readable labels

testActivity <- read.table("./data/test/y_test.txt")
trainActivity <- read.table("./data/train/y_train.txt")

colnames(testActivity) <- c("activityID")
colnames(trainActivity) <- c("activityID")


#-----------------------------------------------------------------------
#       6) read the activity ID table fort "training" and "testing" 
#                paste readable lables




testSubject <- read.table("./data/test/subject_test.txt")
trainSubject <- read.table("./data/train/subject_train.txt")

colnames(testSubject) <- c("SubjectID")
colnames(trainSubject) <- c("SubjectID")


#------------------------------------------------------------------------------
#       6.5) Do some ground work for the merge
# 
#


# for the merge of rows from test and train table, calculate the size and starting
# index for the row labels. 


sizeTest <- nrow(testFeatures)
sizeTrain <- nrow(trainFeatures)
stest <- sizeTrain+1
etest <- sizeTest+sizeTrain


# create individual labels for the row to avoid merging issues. 
# apply row labels to all the tables participating in the merge. 


trainRowLabels <- as.character(1:sizeTrain)
testRowLabels <- as.character(stest:etest)

rownames(testFeatures) <- testRowLabels
rownames(testSubject) <- testRowLabels
rownames(testActivity) <- testRowLabels

rownames(trainFeatures) <- trainRowLabels
rownames(trainSubject) <- trainRowLabels
rownames(trainActivity) <- trainRowLabels


#------------------------------------------------------------------------------
#       7) Merge the feature table with activity table to get activity Name for 
#               corresponding activity ID. SORTING Is disabled. 
#


merge(testActivity,activityLabel,by="activityID", sort=FALSE) -> testActivity
merge(trainActivity,activityLabel,by="activityID",sort=FALSE) ->trainActivity



#------------------------------------------------------------------------------
#       8) Cbind the "training table" & "test table" for the features, subject 
#               and activitynames
#


mtest <- cbind(testFeatures,testSubject,testActivity )
mtrain <- cbind(trainFeatures,trainSubject,trainActivity )

#------------------------------------------------------------------------------
#       9)  horizontally bind using rbind the training table and test table to 
#               form the bigData table containing all the stuff. 
#



bigData <- rbind(mtrain,mtest)


#------------------------------------------------------------------------------
#       10) create dataset 
#               create a subset of data choosing right columns ( the columns
#               which has means and standard deviation )



# get the index number by matching appropriate labels
# the index is retrieved for 
#   a) subjectID
#   b) activityID
#   c) activityName


headings <- colnames(bigData)
subjectIDIndex <- grep("SubjectID",headings)
activityIDIndex <- grep("activityID",headings)
activityNameIndex <- grep("activityName",headings)

featureData <- bigData[,attrIndex]


attrIndex1 <- c(subjectIDIndex,activityNameIndex,attrIndex)

dataset <-  bigData[,attrIndex1]


#===============================================================================
#   data set which has all the merged  variable for mean/std ready 
#===============================================================================

#-------------------------------------------------------------------------------
#       11) create tidyset 
#               using aggregate function, chose subjectInstance and ActivityName 
#               as factors to get the mean of the variables in dataset to form
#               the tidyset



# create factor on Subject ID and activityName 


actFac <- factor(dataset$activityName,exclude="")
subjFac <- factor(dataset$SubjectID,exclude="")
byfac <- list(actFac,subjFac)

aggregate(x=dataset[,c(3:81)],by=byfac,FUN="mean") -> tidyset

# assign readable labels to these factors

colnames(tidyset)[colnames(tidyset) == "Group.1"] <- "activityName"
colnames(tidyset)[colnames(tidyset) == "Group.2"] <-  "SubjectID"


#sort the tidyset
tidyset <-  tidyset[order(tidyset$activityName,tidyset$SubjectID),]

#===============================================================================
#  tidy data set which has <activity,subject> vs mean of all variables pivot ready 
#===============================================================================

#-------------------------------------------------------------------------------
#       12) Save the file bigData, dataset and tidyset as csv files.
#               these files will be used by tabulated using excel to 
#               the algorithm, dataset and tidyset should match with the analysis
#               done by excel.
#
#               Finally save the tidyset as text file with headers and without 
#               row.names to a text file with comma seperated values. 
#
#

write.csv(dataset,"dataset.csv")
write.csv(tidyset,"tidyset.csv")
write.csv(bigData,"bigData.csv")
write.table(tidyset,"tidyset.txt",sep=",",eol = "\n", na = "NA",
        col.names = TRUE,row.names=FALSE)

#===============================================================================

# finally output the tidydataset
#
head(tidyset,n=10)
str(tidyset)
summary(tidyset)






