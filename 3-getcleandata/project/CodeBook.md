"GetCleanData-CourseProject-Codebook"
author: "Kie Gouveia"
date: "Saturday, May 23, 2015"
output: html_document
---

## Description
The purpose of this project is to demostrate my ability to collect, work with and clean a data set. The goal is to prepare a tidy data set which can be used for later analysis. 

The data used for this project come from the 'Human Activity Recognition Using Smartphones Dataset' and represent data collected from accelerometers from the Samsung Galaxy S Smartphone. A full description is available here:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


###Notes on the original (raw) data 
he original data was created through "experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

The original data may be found here:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
 
##Creating the tidy datafile

 
###Guide to create the tidy data file

To create the tidy data file, simply ensure that the run_analysis.R script is in the working directory, and that there is an active internet connection, then run: 

source('run_analysis.R')

This script will ultimately output the "getCleanProject.txt" file. 

NOTE: This script was create in Rstudio, on Windows OS. Therefore, the command to download the file may not translate to Mac OS or Linux OS. 


###Cleaning of the data

In short, the run_analysis.R script:

1. Downloads UCI HAR dataset.
2. Unzips data to working directory.
3. Reads in all training and test data and labels. 
4. Merges the training and test sets. 
5. Ensure that all varible names are descriptive. 
6. Extracts only column pertaining to mean and standard deviation of measurements. 
7. Produces a independent, tidy data set which details the average measurements from each subject, further grouped by each activity. 

For more information, please consult the README.md here: 

[ReadMe](https://github.com/kieg/Get-CleanAssign1/blob/master/README.Rmd)
 
##Description of the variables in the run_analysis.txt file

The final output of run_analysis.R when run on the original Samsung datasetis titled, 'getCleanProject.R'. It may be viewed using the following script (assuming it is in working directory): 

```{r}
tidyData <- read.table("getCleanProject.txt", header = TRUE)
```


Dimensions of the tidy dataset, "getCleanProject.txt":

```{r}
dim(tidyData)
```

[1] 180, 88 

### Variable 1: subject_id

Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
Class: Integer

### Variable 2: activity
Names of activities performed by each subject. Each person performed six unique activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
Class: Character

### Variables 3-88:

Processed variables follow naming structure included in original features.txt, with minor deviations. Original naming convention explanation is included below:

From the UCI HAR 'feature_info.txt' file, the raw dataset variables are described as follows:

*The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.*

*Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).* 

*Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).*

*These signals were used to estimate variables of the feature vector for each pattern:*
*'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.*

*tBodyAcc-XYZ*
*tGravityAcc-XYZ*
*tBodyAccJerk-XYZ*
*tBodyGyro-XYZ*
*tBodyGyroJerk-XYZ*
*tBodyAccMag*
*tGravityAccMag*
*tBodyAccJerkMag*
*tBodyGyroMag*
*tBodyGyroJerkMag*
*fBodyAcc-XYZ*
*fBodyAccJerk-XYZ*
*fBodyGyro-XYZ*
*fBodyAccMag*
*fBodyAccJerkMag*
*fBodyGyroMag*
*fBodyGyroJerkMag*

*The set of variables that were estimated from these signals are:* 

*mean(): Mean value*
*std(): Standard deviation*
*mad(): Median absolute deviation*
*max(): Largest value in array*
*min(): Smallest value in array*
*sma(): Signal magnitude area*
*energy(): Energy measure. Sum of the squares divided by the number of values.* 
*iqr(): Interquartile range* 
*entropy(): Signal entropy*
*arCoeff(): Autorregresion coefficients with Burg order equal to 4*
*correlation(): correlation coefficient between two signals*
*maxInds(): index of the frequency component with largest magnitude*
*meanFreq(): Weighted average of the frequency components to obtain a mean frequency*
*skewness(): skewness of the frequency domain signal* 
*kurtosis(): kurtosis of the frequency domain signal* 
*bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.*
*angle(): Angle between to vectors.*

*Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:*

*gravityMean*
*tBodyAccMean*
*tBodyAccJerkMean*
*tBodyGyroMean*
*tBodyGyroJerkMean*

Once "run_analysis.R" script has been run, processed variables only include variables containing mean, Mean and std.

All variables are prefixed with "avg_" because new values have been averaged according to subject and activity grouping. 

For example:

Row 1 depicts average measurements (of raw mean and standard deviation variables) obtained from Subject 1 while Laying. 

Row 2 depicts average measurements (of mean and standard deviation variables obtained from Subject 1 while Sitting. 

etc..


Complete list of variables in processed data:

```{r}

names(tidyData)

```

 [1] "subject.id"                              
 [2] "activity"                                
 [3] "Avg_tBodyAcc.mean...X"                   
 [4] "Avg_tBodyAcc.mean...Y"                   
 [5] "Avg_tBodyAcc.mean...Z"                   
 [6] "Avg_tBodyAcc.std...X"                    
 [7] "Avg_tBodyAcc.std...Y"                    
 [8] "Avg_tBodyAcc.std...Z"                    
 [9] "Avg_tGravityAcc.mean...X"                
[10] "Avg_tGravityAcc.mean...Y"                
[11] "Avg_tGravityAcc.mean...Z"                
[12] "Avg_tGravityAcc.std...X"                 
[13] "Avg_tGravityAcc.std...Y"                 
[14] "Avg_tGravityAcc.std...Z"                 
[15] "Avg_tBodyAccJerk.mean...X"               
[16] "Avg_tBodyAccJerk.mean...Y"               
[17] "Avg_tBodyAccJerk.mean...Z"               
[18] "Avg_tBodyAccJerk.std...X"                
[19] "Avg_tBodyAccJerk.std...Y"                
[20] "Avg_tBodyAccJerk.std...Z"                
[21] "Avg_tBodyGyro.mean...X"                  
[22] "Avg_tBodyGyro.mean...Y"                  
[23] "Avg_tBodyGyro.mean...Z"                  
[24] "Avg_tBodyGyro.std...X"                   
[25] "Avg_tBodyGyro.std...Y"                   
[26] "Avg_tBodyGyro.std...Z"                   
[27] "Avg_tBodyGyroJerk.mean...X"              
[28] "Avg_tBodyGyroJerk.mean...Y"              
[29] "Avg_tBodyGyroJerk.mean...Z"              
[30] "Avg_tBodyGyroJerk.std...X"               
[31] "Avg_tBodyGyroJerk.std...Y"               
[32] "Avg_tBodyGyroJerk.std...Z"               
[33] "Avg_tBodyAccMag.mean.."                  
[34] "Avg_tBodyAccMag.std.."                   
[35] "Avg_tGravityAccMag.mean.."               
[36] "Avg_tGravityAccMag.std.."                
[37] "Avg_tBodyAccJerkMag.mean.."              
[38] "Avg_tBodyAccJerkMag.std.."               
[39] "Avg_tBodyGyroMag.mean.."                 
[40] "Avg_tBodyGyroMag.std.."                  
[41] "Avg_tBodyGyroJerkMag.mean.."             
[42] "Avg_tBodyGyroJerkMag.std.."              
[43] "Avg_fBodyAcc.mean...X"                   
[44] "Avg_fBodyAcc.mean...Y"                   
[45] "Avg_fBodyAcc.mean...Z"                   
[46] "Avg_fBodyAcc.std...X"                    
[47] "Avg_fBodyAcc.std...Y"                    
[48] "Avg_fBodyAcc.std...Z"                    
[49] "Avg_fBodyAcc.meanFreq...X"               
[50] "Avg_fBodyAcc.meanFreq...Y"               
[51] "Avg_fBodyAcc.meanFreq...Z"               
[52] "Avg_fBodyAccJerk.mean...X"               
[53] "Avg_fBodyAccJerk.mean...Y"               
[54] "Avg_fBodyAccJerk.mean...Z"               
[55] "Avg_fBodyAccJerk.std...X"                
[56] "Avg_fBodyAccJerk.std...Y"                
[57] "Avg_fBodyAccJerk.std...Z"                
[58] "Avg_fBodyAccJerk.meanFreq...X"           
[59] "Avg_fBodyAccJerk.meanFreq...Y"           
[60] "Avg_fBodyAccJerk.meanFreq...Z"           
[61] "Avg_fBodyGyro.mean...X"                  
[62] "Avg_fBodyGyro.mean...Y"                  
[63] "Avg_fBodyGyro.mean...Z"                  
[64] "Avg_fBodyGyro.std...X"                   
[65] "Avg_fBodyGyro.std...Y"                   
[66] "Avg_fBodyGyro.std...Z"                   
[67] "Avg_fBodyGyro.meanFreq...X"              
[68] "Avg_fBodyGyro.meanFreq...Y"              
[69] "Avg_fBodyGyro.meanFreq...Z"              
[70] "Avg_fBodyAccMag.mean.."                  
[71] "Avg_fBodyAccMag.std.."                   
[72] "Avg_fBodyAccMag.meanFreq.."              
[73] "Avg_fBodyBodyAccJerkMag.mean.."          
[74] "Avg_fBodyBodyAccJerkMag.std.."           
[75] "Avg_fBodyBodyAccJerkMag.meanFreq.."      
[76] "Avg_fBodyBodyGyroMag.mean.."             
[77] "Avg_fBodyBodyGyroMag.std.."              
[78] "Avg_fBodyBodyGyroMag.meanFreq.."         
[79] "Avg_fBodyBodyGyroJerkMag.mean.."         
[80] "Avg_fBodyBodyGyroJerkMag.std.."          
[81] "Avg_fBodyBodyGyroJerkMag.meanFreq.."     
[82] "Avg_angle.tBodyAccMean.gravity."         
[83] "Avg_angle.tBodyAccJerkMean..gravityMean."
[84] "Avg_angle.tBodyGyroMean.gravityMean."    
[85] "Avg_angle.tBodyGyroJerkMean.gravityMean."
[86] "Avg_angle.X.gravityMean."                
[87] "Avg_angle.Y.gravityMean."                
[88] "Avg_angle.Z.gravityMean." 


