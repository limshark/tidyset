### COOK BOOK for tidyset

The tidyset is the mean of the variable for the The mean of variables as outlined by **Human Activity Recognition Using Smartphones Dataset**
These are defined in the `data/README.txt`, Though reproduced here verbatim. the way each value is computed is already described in the 
file described above and hence will not be repeated in this file. only those variable which are added are explained in this file. 


the tidyset describes the computed `mean` of all captured activities for the captured subjects, 

```
mean of Variables  vs.  <activity,subject>
```

## Human Activity Recognition Using Smartphones Dataset
Version 1.1

Original `data\README.txt`

```
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
```

### Code Book details for the variables newly added

```
1 "activityName"
          character()
          the name of the activity which was being performed
          
          LAYING 
          SITTING 
          STANDING 
          WALKING 
          WALKING_DOWNSTAIRS 
          WALKING_UPSTAIRS


2 "SubjectID"
          numeric()
          The unique ID of the Subject of the experiment
          

```

### The details about these variables can be fetched by contacting the  [Email:Original Authors(activityrecognition@smartlab.ws)](activityrecognition@smartlab.ws)

* All variables are numeric
* all values are mean of these variables
* all values are normalized between -1 and 1

### Following mapping tables maps the *current column names* to the *names* and *indices* of the pre-processed data

```
=====================================================================================
Current
Index         "Name in tidyset"            "Original Name""           Earlier Index
=====================================================================================
            
"1"               "activityName"                  NA                            "562"
"2"               "SubjectID"                     NA                            "564"
"3"               "tBodyAcc_mean_X"               "tBodyAcc-mean()-X"             "1"
"4"               "tBodyAcc_mean_Y"               "tBodyAcc-mean()-Y"             "2"
"5"               "tBodyAcc_mean_Z"               "tBodyAcc-mean()-Z"             "3"
"6"               "tBodyAcc_std_X"               "tBodyAcc-std()-X"               "4"
"7"               "tBodyAcc_std_Y"               "tBodyAcc-std()-Y"               "5"
"8"               "tBodyAcc_std_Z"               "tBodyAcc-std()-Z"               "6"
"9"               "tGravityAcc_mean_X"            "tGravityAcc-mean()-X"          "41"
"10"               "tGravityAcc_mean_Y"           "tGravityAcc-mean()-Y"          "42"
"11"               "tGravityAcc_mean_Z"           "tGravityAcc-mean()-Z"          "43"
"12"               "tGravityAcc_std_X"            "tGravityAcc-std()-X"           "44"
"13"               "tGravityAcc_std_Y"            "tGravityAcc-std()-Y"           "45"
"14"               "tGravityAcc_std_Z"            "tGravityAcc-std()-Z"           "46"
"15"               "tBodyAccJerk_mean_X"          "tBodyAccJerk-mean()-X"         "81"
"16"               "tBodyAccJerk_mean_Y"          "tBodyAccJerk-mean()-Y"           "82"
"17"               "tBodyAccJerk_mean_Z"          "tBodyAccJerk-mean()-Z"           "83"
"18"               "tBodyAccJerk_std_X"           "tBodyAccJerk-std()-X"            "84"
"19"               "tBodyAccJerk_std_Y"           "tBodyAccJerk-std()-Y"            "85"
"20"               "tBodyAccJerk_std_Z"           "tBodyAccJerk-std()-Z"            "86"
"21"               "tBodyGyro_mean_X"             "tBodyGyro-mean()-X"               "121"
"22"               "tBodyGyro_mean_Y"             "tBodyGyro-mean()-Y"               "122"
"23"               "tBodyGyro_mean_Z"             "tBodyGyro-mean()-Z"               "123"
"24"               "tBodyGyro_std_X"              "tBodyGyro-std()-X"               "124"
"25"               "tBodyGyro_std_Y"              "tBodyGyro-std()-Y"               "125"
"26"               "tBodyGyro_std_Z"               "tBodyGyro-std()-Z"               "126"
"27"               "tBodyGyroJerk_mean_X"         "tBodyGyroJerk-mean()-X"            "161"
"28"               "tBodyGyroJerk_mean_Y"         "tBodyGyroJerk-mean()-Y"            "162"
"29"               "tBodyGyroJerk_mean_Z"         "tBodyGyroJerk-mean()-Z"            "163"
"30"               "tBodyGyroJerk_std_X"         "tBodyGyroJerk-std()-X"              "164"
"31"               "tBodyGyroJerk_std_Y"         "tBodyGyroJerk-std()-Y"              "165"
"32"               "tBodyGyroJerk_std_Z"         "tBodyGyroJerk-std()-Z"              "166"
"33"               "tBodyAccMag_mean"           "tBodyAccMag-mean()"                "201"
"34"               "tBodyAccMag_std"            "tBodyAccMag-std()"                 "202"
"35"               "tGravityAccMag_mean"         "tGravityAccMag-mean()"            "214"
"36"               "tGravityAccMag_std"           "tGravityAccMag-std()"            "215"
"37"               "tBodyAccJerkMag_mean"         "tBodyAccJerkMag-mean()"          "227"
"38"               "tBodyAccJerkMag_std"           "tBodyAccJerkMag-std()"          "228"
"39"               "tBodyGyroMag_mean"               "tBodyGyroMag-mean()"          "240"
"40"               "tBodyGyroMag_std              "tBodyGyroMag-std()"              "241"
"41"               "tBodyGyroJerkMag_m             "tBodyGyroJerkMag-mean()"        "253"
"42"               "tBodyGyroJerkMag_std"         "tBodyGyroJerkMag-std()"          "254"
"43"               "fBodyAcc_mean_X"               "fBodyAcc-mean()-X"              "266"
"44"               "fBodyAcc_mean_Y"               "fBodyAcc-mean()-Y"              "267"
"45"               "fBodyAcc_mean_Z"               "fBodyAcc-mean()-Z"              "268"
"46"               "fBodyAcc_std_X"               "fBodyAcc-std()-X"               "269"
"47"               "fBodyAcc_std_Y"               "fBodyAcc-std()-Y"               "270"
"48"               "fBodyAcc_std_Z"             "fBodyAcc-std()-Z"                  "271"
"49"               "fBodyAcc_meanFreq_X"         "fBodyAcc-meanFreq()-X"            "294"
"50"               "fBodyAcc_meanFreq_Y"           "fBodyAcc-meanFreq()-Y"          "295"
"51"               "fBodyAcc_meanFreq_Z"         "fBodyAcc-meanFreq()-Z"            "296"
"52"               "fBodyAccJerk_mean_X"          "fBodyAccJerk-mean()-X"           "345"
"53"               "fBodyAccJerk_mean_Y"           "fBodyAccJerk-mean()-Y"          "346"
"54"               "fBodyAccJerk_mean_Z"           "fBodyAccJerk-mean()-Z"          "347"
"55"               "fBodyAccJerk_std_X"             "fBodyAccJerk-std()-X"          "348"
"56"               "fBodyAccJerk_std_Y"             "fBodyAccJerk-std()-Y"          "349"
"57"               "fBodyAccJerk_std_Z"             "fBodyAccJerk-std()-Z"          "350"
"58"               "fBodyAccJerk_meanFreq_X"         "fBodyAccJerk-meanFreq()-X"    "373"
"59"               "fBodyAccJerk_meanFreq_Y"         "fBodyAccJerk-meanFreq()-Y"    "374"
"60"               "fBodyAccJerk_meanFreq_Z         "fBodyAccJerk-meanFreq()-Z"     "375"
"61"               "fBodyGyro_mean_X"               "fBodyGyro-mean()-X"            "424"
"62"               "fBodyGyro_mean_Y"               "fBodyGyro-mean()-Y"            "425"
"63"               "fBodyGyro_mean_Z"               "fBodyGyro-mean()-Z"            "426"
"64"               "fBodyGyro_std_X"               "fBodyGyro-std()-X"              "427"
"65"               "fBodyGyro_std_Y"               "fBodyGyro-std()-Y"              "428"
"66"               "fBodyGyro_std_Z"               "fBodyGyro-std()-Z"              "429"
"67"               "fBodyGyro_meanFreq_X"           "fBodyGyro-meanFreq()-X"        "452"
"68"               "fBodyGyro_meanFreq_Y"           "fBodyGyro-meanFreq()-Y"        "453"
"69"               "fBodyGyro_meanFreq_Z"           "fBodyGyro-meanFreq()-Z"        "454"
"70"               "fBodyAccMag_mean"               "fBodyAccMag-mean()"            "503"
"71"               "fBodyAccMag_std"                "fBodyAccMag-std()"             "504"
"72"               "fBodyAccMag_meanFreq"           "fBodyAccMag-meanFreq()"        "513"
"73"               "fBodyBodyAccJerkMag_mean"       "fBodyBodyAccJerkMag-mean()"    "516"
"74"               "fBodyBodyAccJerkMag_std"        "fBodyBodyAccJerkMag-std()"     "517"
"75"               "fBodyBodyAccJerkMag_meanFreq"   "fBodyBodyAccJerkMag-meanFreq()"  "526"
"76"               "fBodyBodyGyroMag_mean"            "fBodyBodyGyroMag-mean()"       "529"
"77"               "fBodyBodyGyroMag_std"             "fBodyBodyGyroMag-std()"        "530"
"78"               "fBodyBodyGyroMag_meanFreq"        "fBodyBodyGyroMag-meanFreq()"   "539"
"79"               "fBodyBodyGyroJerkMag_mean"        "fBodyBodyGyroJerkMag-mean()"   "542"
"80"               "fBodyBodyGyroJerkMag_std"         "fBodyBodyGyroJerkMag-std()"    "543"
"81"               "fBodyBodyGyroJerkMag_meanFreq"    "fBodyBodyGyroJerkMag-meanFreq()" "552"

```



