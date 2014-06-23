README file for the run_analysis.R Code. 
========================================================

This file provides the explaination about the run_analysis.R. 

####Objective of the code. 
        This file implements the course project requirements which are provided below. 
        

*As per the Project requirements, the purpose is reproduced verbatm here*.

```
The purpose of this project is to demonstrate your ability to 
collect, work with, and clean a data set. The goal is to 
prepare tidy data that can be used for later analysis. You will
be graded by your peers on a series of yes/no questions related 
to the project. You will be required to submit: 
        1) a tidy data set as described below, 
        2) a link to a Github repository with your script for performing the analysis, 
and 3) a code book that describes the variables, the data, and any 
                 transformations or work that you performed to clean up the data 
                         called CodeBook.md. 
 You should also include a README.md in the repo with your scripts. 
 This repo explains how all of the scripts work and how they are 
 connected.
 
```

### The requirements

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### The Project Directory Contents. 

The samsung data is downloaded and unzipped in the project directory where the run_analysis.R file resides. 

the details about the project directory  structures is as given below. 

the code directory has following files 

1. run_analysis.R : the R program which creates the tinydata as per the course requirements. 
2. README.md    : The file which describes the overall objective, code and other information about the product. 
3. CodeBook.md  : The file which describes how to interpret the tidydata created by the run_analysis.R program
4. tidydata.txt : the tinydata which is created  from the run_analysis.R program as part of the project. 

In addition to these files, the source files and published files are also mentioned as given below. 

5.1  CodeBook.Rmd : the source code for Code book documentation which generates CodeBook.md file and CodeBook.html file. 
5.2  README.Rmd :   the source code for the README.md file which is sourced to generate README.md file and README.html file

all these files are kept in the GIT repository as [Git repository](https://github.com/limshark/tidyset)


### The project data

In addition to these files,  the *samsung data* is copied in the project ROOT directory. 

[ *the Samsung Data*   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


Manually the file is downloaded and unzipped in the project root directory, due to the large size of the file and the file is not modified, this file is decided not to be put in the GIT repository. 

* created a directory `data` in the project ROOT directory and unzipped `UCI HAR Dataset.zip` file in the `data` directory. 
* The R program assumes that the important files are read from the `data` directory. 
* the `UCI HAR Dataset` contents are not described here, those are already described in the `data/README.txt`

### The High level algorithm



       1) Prepare the feature labels
               read the labels
               transform the labels to readable format. 
     
       2) Extract the column for the Mean and Standard deviation

       3) Read the activity Labels from the file ( Activity ID vs Activity Name)

       4) read the feature extraction table for "Training" and "Testing"

       5) read the subject table for the "training" and "testing" 
                paste readable labels

       6) read the activity ID table fort "training" and "testing" 
                paste readable lables

       7) Merge the feature table with activity table to get activity Name for 
               corresponding activity ID. 

       8) Cbind the "training table" & "test table" for the features, subject 
               and activitynames

       9)  horizontally bind using rbind the training table and test table to 
               form the bigData table containing all the stuff. 

       10) create dataset 
               create a subset of data choosing right columns ( the columns
               which has means and standard deviation )
       
       11) create tidyset 
               using aggregate function, chose subjectInstance and ActivityName 
               as factors to get the mean of the variables in tidyset to form
               the tidyset

       12) Save the file bigData, dataset and tidyset as csv files.
               these files will be used by tabulated using excel to 
               the algorithm, dataset and tidyset should match with the analysis
               done by excel.
       
               finally save the tidyset as table in a .txt comma seperated text 
               format

### The detailed source flow explaination...

```{r}

source('run_analysis.R')
```

```
#--------------------------------------------------------------
#       1) Prepare the feature labels
#               read the labels
#               transform the labels to readable format. 


featuresLabel <-  read.table("./data/features.txt")
labelsList <- as.character(featuresLabel$V2)

```
The `featuresLabel` dataframe contains features numeric value vs the possible labels.
these labels are transformed using `sapply()` and `gsub()` functions.

```


# Beautify the Label 
#       replace  "()"  to "_"
#       do not touch "(somecontent)" 
#       replace "-" with "_"

labelsList <- sapply(labelsList, function(i) { 
        x <- gsub("[(]+[)]+","",i) 
        gsub("-","_",x)
})

```
The `-` to `_` is required to avoid the interpretation of minus in the formula
as the labels are quite satisfactory detailed, I decided to just replace () this with _ without
touching the strings which has parameters such as `(parameters,parameters2)`

```


labelsList <- as.character(labelsList)

```
this transformation is required so to enable labels to be applied for the `colnames()`

####  the Labels 

```{r}

#

```

```

#  --------------------------------------------------------------   
#       2) Extract the column for the Mean and Standard deviation
#
# get only features for "mean" for mean and "std" for standard deviation
#     by using grep 

# get the indices which has only mean and std words in it. 
#


```
here `mean` and `std` keyword to filter column to signify mean and standard deviation. 
find all columns which has `mean` and create a union with the indices found for `std`
these indices are sorted in increasing order. 
```

meanIndex <- grep("mean",labelsList)
stdIndex <- grep("std",labelsList)

# merge these two lists and sort the list 

meanOrStdIndex <- meanIndex
meanOrStdIndex <- c(meanOrStdIndex,stdIndex)
meanOrStdIndex <- sort(meanOrStdIndex)
attrIndex <- meanOrStdIndex 
size_attrIndex <- length(attrIndex)

```
`attrIndex` contains list of only those columns which has mean and std as part of the label, though there was choice to made to drop some
column which has meanFreq  word in it. Choice was made to include even those columns with the priciple that better to have extra columns, 
```

#  -----------------------------------------------------------------------------
#      3) Read the activity Labels from the file ( Activity ID vs Activity Name)
#
#


activityLabel <- read.table("./data/activity_labels.txt")

# providing meaningful labels : a) activityID  and b) activityName 

colnames(activityLabel) <- c("activityID", "activityName")


#--------------------------------------------------------------------------
#       4) read the feature extraction table for "Training" and "Testing"
#



```
the prefix `test` and `train` signifies the data which are read under `test` or `train` condition,
the corresponding files are available in `X_test.txt` and `X_train.txt` 

```

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

```
`SubjectID` is the number identifying the subject
```

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

```
`stest` is the index for the start of test data
`etest` is the ending index for the test data

idea is first `training rows` are put and then `test rows` are put for the row merges. 

```

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



l<- activityLabel
for ( i in  seq_len(nrow(testActivity)))  {
  testActivity$activityName[i] <- as.character(l[l$activityID ==  testActivity$activityID[i],]$activityName)
}

for ( i in  seq_len(nrow(trainActivity)))  {
  trainActivity$activityName[i] <- as.character(l[l$activityID == trainActivity$activityID[i],]$activityName)
}

trainActivity1 <- trainActivity
testActivity1 <- testActivity


```
the merge to get the activity label for corresponding ID, **SORTING** is disabled to ensure no auto sorting is performed. 
```

#------------------------------------------------------------------------------
#       8) Cbind the "training table" & "test table" for the features, subject 
#               and activitynames
#
```
`mtest` and `mtrain` represent the horizontally concatenated `features`, `subject` and `activity` for `test` and `train` respectively.
```


mtest <- cbind(testFeatures,testSubject,testActivity )
mtrain <- cbind(trainFeatures,trainSubject,trainActivity )

#------------------------------------------------------------------------------
#       9)  horizontally bind using rbind the training table and test table to 
#               form the bigData table containing all the stuff. 
#


bigData <- rbind(mtrain,mtest)

```
finally bigData procides data frame which has rows from train table and test table merged.


```{r}
dim(bigData)
#colnames(bigData)
```


```
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


```
dataset is the data set which has all the rows combined *10299* rows and *81* columns. 


```{r}
dim(dataset)
head(dataset,n=4)
```
```
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

```
##tidyset created
tidy data set which has `<activity,subject>` vs `mean` of all variables pivot ready 

### example display with 3 variables 


```{r}
dim(tidyset)
str(tidyset)
tidyset[,c(1,2,3,4)]
```


```
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


```


```{r}
#source("run_analysis.R")
```




### How to use the data from the `tidyset.txt`


```
read.table("tidyset.txt",sep=",", header=TRUE) -> tt
tt[,c(1,2,3,4)]
```
