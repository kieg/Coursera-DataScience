# Coursera - Getting and Cleaning Data
## Course project

## Author: Kie Gouveia
## 2015-05-24

# Download project files into working directory and unzip.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("./UCI HAR Dataset")){
download.file(fileUrl, "./projectdataset.zip")
unzip("projectdataset.zip")
}


# Check if plyr and dplyr are installed. If they are not, install. 
if("plyr" %in% rownames(installed.packages()) == FALSE) {install.packages("plyr")}
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}

library(plyr)  # load plyr package
library(dplyr) #load dplyr package


# Read in features and activity data. Use tbl_df from dplyr package to optimize dataframes. 
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
features <- tbl_df(features)

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
activity_labels <- tbl_df(activity_labels)

# Read in training set, training labels, and subject training information.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
X_train <- tbl_df(X_train)

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
y_train <- tbl_df(y_train)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
subject_train <- tbl_df(subject_train)

# Read in test set, test labels, and subject test information.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
X_test <- tbl_df(X_test)

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
y_test <- tbl_df(y_test)

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
subject_test <- tbl_df(subject_test)

# Attach subject information and activity labels to training and test sets
train.all <- cbind(subject_train, y_train, X_train)
test.all  <- cbind(subject_test, y_test, X_test)

## 1. Merge the training and the test sets to create one data set.
all.sets  <- rbind(train.all, test.all)

## 2. Extract the measurements containing the mean and standard deviation using an index given by grep, 
# keeping subject.id and activities.

mean.Std.Columns <- grep("[Mm]ean|std", features$V2, value = FALSE)

all.Mean.Std <- all.sets[,c(1,2,mean.Std.Columns+2)]

## 4.Appropriately labels the data set with descriptive variable names. 

# Using a grep index which returns names, update column names 
# Opted to use names in the features file because I find them explanatory and concise. Full details about
# each may be found in the Readme.

colnames(all.Mean.Std) <- c("subject.id", 
                        "activity",
                        grep("[Mm]ean|std", features$V2, value = TRUE))


## 3. Use descriptive activity names to name the activities in the dataset.

# Rename activities from numeric code to descriptive titles according the activities worksheet.
for(i in 1:length(activity_labels$V2)){
  all.Mean.Std[all.Mean.Std$activity %in% i, "activity"] <- with(activity_labels, subset(V2, V1 == i))
}

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject.

# Group data first by subject.id, then by activity.

all.Mean.Std.Activity <- all.Mean.Std %>%
  group_by(subject.id, activity)

# Calculate the mean of each variable, grouped by subject and each activity. 
subject.Activity.Mean <- all.Mean.Std.Activity %>%
  summarise_each(funs(mean))

# Rename columns to explain that each variable is now an average of previous variables.
colnames(subject.Activity.Mean)[3:length(subject.Activity.Mean)] <- paste("Avg", colnames(subject.Activity.Mean)[3:length(subject.Activity.Mean)], sep = "_")

# Create table
write.table(subject.Activity.Mean, "tidyData.txt", row.name = FALSE)

# To read data:
# tidyData <- read.table("getCleanProject.txt", header = TRUE)
